#!/usr/bin/env python
# coding=utf-8

import os
import platform
import re
import utils
import urllib
import urllib2
import md5
import sys
import getopt
import json
import shutil
import datetime
import time
from distutils.version import LooseVersion
from argparse import ArgumentParser


def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-a", "--app", dest="app")
    parser.add_argument("-o", "--outPath", dest="outPath")
    parser.add_argument("-v", "--version", dest="version")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # publish/tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # publish/xgame
    dirProject          = os.path.join(dirScript, "..", "..", "xgame")
    # publish/xgame/frameworks
    dirProjectFramework = os.path.join(dirProject, "frameworks")
    # publish/tools/config
    dirConfig           = os.path.join(dirScript, "..", "config")
    # publish/xgame/runtime/ios
    dirRuntime          = os.path.join(dirScript, "..", "..", "xgame", "simulator", "ios")
    # publish/xgame/sdk
    dirSdkTemp          = os.path.join(dirProject, "sdk")
    # publish/sdk
    dirSdk              = os.path.join(dirScript, "..", "..", "sdk")

    dirShareSdk         = os.path.join(dirScript, "..", "..", "share")
    #
    dirPublish          = os.path.join(dirScript, "..", "..", "install")
    #
    dirExport           = os.path.join(dirProject, "export")


    # 读取配置
    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)
    cfgFileApp          = utils.getAppConfig(dirConfig, args.config, args.app)
    cfgPackExt          = "assets"
    cfgApp              = cfgFileApp["app"]
    cfgChannel          = cfgApp["ios"]
    cfgAppProvisioning  = cfgChannel["provisioning"]
    cfgAppPackage       = cfgChannel["identifier"]
    cfgUrl              = cfgFileVersion["url"]
    cfgVersionList      = cfgFileVersion["version"]
    cfgNewVersion       = cfgFileVersion["version"][-1]
    cfgBuildMode        = "release"

    # 国际化配置
    cfgI18n             = cfgFileApp["i18n"] if cfgFileApp.has_key("i18n") else {} 
    cfgReplace          = cfgI18n["replace"]


    if args.version != None and args.version != "new":
        for version in cfgVersionList:
            if version["name"] == args.version:
                cfgNewVersion = version
                break

    if cfgBuildMode == "release":
        dirRuntime = os.path.join(dirScript, "..", "..", "xgame", "publish", "ios")

    # 更新svn
    utils.printSplit("更新svn")
    cmd = "svn revert --depth infinity %s" % (dirProjectFramework)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)
    
    svnInfo = utils.getSVNInfo()
    cmd = "svn update --accept theirs-full --username %s --password %s %s" % (svnInfo["n"], svnInfo["p"], dirProjectFramework)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    cmd = "svn status %s" % (dirProjectFramework)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    backupAllFileList = list()
    #
    utils.printSplit("修改AppDelegate.cpp")
    utils.modifyAppDelegate(backupAllFileList, os.path.join(dirProjectFramework, "runtime-src/Classes/AppDelegate.cpp"), cfgApp["run"])

    # 根据需求修改 top_server
    if cfgI18n.has_key("top_server"):
        utils.printSplit("修改topserver")
        print("修改topserver地址:%s" % cfgI18n["top_server"])
        nativeAgentFileName = os.path.join(dirProjectFramework, "runtime-src/proj.ios_mac/ios/NativeAgent.mm")
        utils.modifyFile(backupAllFileList,nativeAgentFileName, lambda f, line:
            f.write(re.sub("[\s\t]*NSString\* TOP_SERVER_URL[\s\t]*=[\s\t]*\@\".*\".*",
        "    NSString* TOP_SERVER_URL = @\"%s\";" % cfgI18n["top_server"], line))
        )
    
    #
    #utils.cleanDir(dirPublish,[])
    utils.cleanDir(dirSdkTemp,[])

    # 备份文件
    backupFileList = list()
    plistFileName = os.path.join(dirProjectFramework, "runtime-src/proj.ios_mac/ios/Info.plist")
    utils.backUpFile(backupFileList, plistFileName)
    pbxprojFileName = os.path.join(dirProjectFramework, "runtime-src/proj.ios_mac/xgame.xcodeproj/project.pbxproj")
    utils.backUpFile(backupFileList, pbxprojFileName)
    #utils.cleanDir(dirPublish,[])


    utils.printSplit("开始打包（%s）" % cfgChannel["name"])

    # 拷贝当前渠道sdk文件
    utils.cleanDir(dirSdkTemp,[])
    utils.copyDir(os.path.join(dirSdk, "ios", cfgChannel["sdk"]), dirSdkTemp)
    utils.restoreFile(backupFileList)


    # 根据渠道需求合并修改info.plist
    utils.printSplit("修改Info.plist")
    dirSdkInfoPlist = os.path.join(dirSdkTemp, "info", "info.plist")
    if os.path.exists(dirSdkInfoPlist):
        cmd = '/usr/libexec/PlistBuddy -c "Merge %s" %s'%(dirSdkInfoPlist, plistFileName)
        os.system(cmd)
    #打开麦克风提示
    if cfgReplace and cfgReplace.has_key("mic_desc"):
        cmd = '/usr/libexec/PlistBuddy -c "Set:NSMicrophoneUsageDescription %s" %s'%(cfgReplace["mic_desc"], plistFileName)
        os.system(cmd)
    #默认app 开发地区语言
    if cfgReplace and cfgReplace.has_key("language"):
        cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleDevelopmentRegion %s" %s'%(cfgReplace["language"], plistFileName)
        os.system(cmd)
    #修改 bundle name
    if cfgReplace and cfgReplace.has_key("bundle_name"):
        cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleName %s" %s'%(cfgReplace["bundle_name"], plistFileName)
        os.system(cmd)
    #
    if cfgNewVersion.has_key("build"):
        cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleVersion %s" %s'%(cfgNewVersion["build"], plistFileName)
        os.system(cmd)
    else:
        cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleVersion %s" %s'%(cfgNewVersion["name"], plistFileName)
        os.system(cmd)
        
    cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleShortVersionString %s" %s'%(cfgNewVersion["name"], plistFileName)
    os.system(cmd)
    utils.printFile(plistFileName, "Info.plist")

    cfgEntitlements = None
    #是否包含远程推送配置
    if cfgReplace and cfgReplace.has_key("entitlements"):
        cfgEntitlements = cfgReplace["entitlements"]
        if cfgEntitlements == "":
            cfgEntitlements = "xgame-mobile.entitlements"

        sdkEntitlementsPath = os.path.join(dirSdkTemp,"info",cfgEntitlements)  
        targetEntitlementsPath = os.path.join(dirProjectFramework, "runtime-src/proj.ios_mac/")  
        if  os.path.isfile(sdkEntitlementsPath) and os.path.exists(targetEntitlementsPath):
            if os.path.isfile(os.path.join(targetEntitlementsPath,cfgEntitlements)):
                utils.removeFile(sdkEntitlementsPath)
            else:
                shutil.move(sdkEntitlementsPath,targetEntitlementsPath) 
                # print("move " + sdkEntitlementsPath + "  to  " + targetEntitlementsPath)

    # 兼容adhoc
    devExport = "ios_export_dev.plist" 
    disExport = "ios_export_dis.plist" 
    adhocExport = "ios_export_adhoc.plist" 
    isAdhoc = False
    
    if cfgAppProvisioning.has_key("development"):
        debugProvisioning = cfgAppProvisioning["development"]["profiles"] 
    if cfgAppProvisioning.has_key("distribution"):
        releaseProvisioning = cfgAppProvisioning["distribution"]["profiles"] 
        releaseExport = disExport
    if cfgAppProvisioning.has_key("adhoc"):
        releaseProvisioning = cfgAppProvisioning["adhoc"]["profiles"] 
        releaseExport = adhocExport
        isAdhoc = True

    debugExport = devExport

    utils.printFile(pbxprojFileName, "旧 project.pbxproj")

    # 根据渠道配置修改xcode工程
    utils.printSplit("修改Xcodeproj")
    cmd = "ruby %s %s %s %s '%s' %s %s %s %s" % (os.path.join(dirScript, "..", "external", "xcodeproj.rb"), 
                                    os.path.abspath(dirProject), 
                                    cfgChannel["target"], 
                                    cfgAppPackage, 
                                    cfgApp["name"], 
                                    cfgAppProvisioning["teamID"],
                                    debugProvisioning,
                                    releaseProvisioning,
                                    cfgEntitlements)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)
    utils.printFile(pbxprojFileName, "project.pbxproj")

    time.sleep(10)

    # 拷贝导出配置
    utils.mkOutDir(dirExport, True)
    shutil.copy(os.path.join(dirConfig, debugExport), 
        os.path.join(dirExport, debugExport))
    shutil.copy(os.path.join(dirConfig, releaseExport), 
        os.path.join(dirExport, releaseExport))

    # 设置导出配置
    exportOption = os.path.join(dirExport, debugExport)
    cmd = '/usr/libexec/PlistBuddy -c "Add :provisioningProfiles:%s string %s" %s'%(cfgChannel["identifier"], debugProvisioning, exportOption)
    print(cmd)
    os.system(cmd)
    cmd = '/usr/libexec/PlistBuddy -c "Set:teamID %s" %s'%(cfgAppProvisioning["teamID"], exportOption)
    print(cmd)
    os.system(cmd)

    # 设置导出配置
    exportOption = os.path.join(dirExport, releaseExport)
    cmd = '/usr/libexec/PlistBuddy -c "Add :provisioningProfiles:%s string %s" %s'%(cfgChannel["identifier"], releaseProvisioning, exportOption)
    print(cmd)
    os.system(cmd)
    cmd = '/usr/libexec/PlistBuddy -c "Set:teamID %s" %s'%(cfgAppProvisioning["teamID"], exportOption)
    print(cmd)
    os.system(cmd)

    # 编译
    use_sdk = 'iphoneos'
    dirProjectXcodeproj = os.path.join(dirProjectFramework, "runtime-src", "proj.ios_mac", "xgame.xcodeproj")
    archive_path = os.path.join(dirRuntime, "%s.xcarchive" % cfgChannel["target"])
    cmd = ' '.join([
                "xcodebuild",
                "archive",
                "-project",
                "\"%s\"" % dirProjectXcodeproj,
                "-configuration",
                "%s" % 'Debug' if cfgBuildMode == 'debug' else 'Release',
                "-scheme", 
                "\"%s\"" % cfgChannel["target"],
                "%s" % "-arch i386" if use_sdk == 'iphonesimulator' else '',
                "-sdk",
                "%s" % use_sdk,
                "-archivePath",
                "%s" % archive_path,
                "%s" % "VALID_ARCHS=\"i386\"" if use_sdk == 'iphonesimulator' else ''
                ])
    print(cmd)
    os.system(cmd)


    # 导出ipa
    dirPublishInstall = args.outPath
    if os.path.exists(archive_path):
        # 导出 .dSYM
        out_time = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        dirPublishInstall = os.path.join(args.outPath, "%s_%s_%s_%s_%s" %(cfgApp["file"], cfgNewVersion["name"], cfgBuildMode, cfgAppPackage, out_time))
        if not os.path.exists(dirPublishInstall):
            os.makedirs(dirPublishInstall)
        dsym_path = os.path.join(archive_path, "dSYMs", "%s.app.dSYM" % cfgChannel["target"])
        dsym_new_path = os.path.join(dirPublishInstall, "%s_%s_%s_%s_%s.app.dSYM" % (cfgApp["file"], cfgNewVersion["name"], cfgBuildMode, cfgAppPackage, out_time))
        if os.path.exists(dsym_path):
            utils.copyDir(dsym_path, dsym_new_path)

        #
        dirRuntimeDev = os.path.join(dirRuntime, "dev")
        if not os.path.exists(dirRuntimeDev):
            os.makedirs(dirRuntimeDev)
        cmd = ' '.join([
            "xcodebuild",
            "-exportArchive",
            "-archivePath %s" % archive_path,
            "-exportPath %s" % dirRuntimeDev,
            "-exportOptionsPlist %s" % os.path.join(dirExport, debugExport)
        ])
        print(cmd)
        os.system(cmd)       
        _, filepath = utils.checkFileByExtention(".ipa", dirRuntimeDev)
        appPath = os.path.join(dirRuntimeDev, filepath)
        newPath = os.path.join(dirRuntimeDev, "%s_dev_%s_%s_%s_%s.ipa" % (cfgApp["file"], cfgNewVersion["name"], cfgBuildMode, cfgAppPackage, datetime.datetime.now().strftime('%Y%m%d%H%M%S')))
        if os.path.exists(appPath):
            os.rename(appPath, newPath)
            if not os.path.exists(dirPublishInstall):
                os.makedirs(dirPublishInstall)
            shutil.copy(newPath, dirPublishInstall)

        #
        dirRuntimeDis = os.path.join(dirRuntime, "dis")
        if not os.path.exists(dirRuntimeDis):
            os.makedirs(dirRuntimeDis)
        cmd = ' '.join([
            "xcodebuild",
            "-exportArchive",
            "-archivePath %s" % archive_path,
            "-exportPath %s" % dirRuntimeDis,
            "-exportOptionsPlist %s" % os.path.join(dirExport, releaseExport)
        ])
        print(cmd)
        os.system(cmd) 
        _, filepath = utils.checkFileByExtention(".ipa", dirRuntimeDis)
        appPath = os.path.join(dirRuntimeDis, filepath)
        if isAdhoc:
            newPath = os.path.join(dirRuntimeDis, "%s_adhoc_%s_%s_%s_%s.ipa" % (cfgApp["file"], cfgNewVersion["name"], cfgBuildMode, cfgAppPackage, datetime.datetime.now().strftime('%Y%m%d%H%M%S')))
        else:    
            newPath = os.path.join(dirRuntimeDis, "%s_dis_%s_%s_%s_%s.ipa" % (cfgApp["file"], cfgNewVersion["name"], cfgBuildMode, cfgAppPackage, datetime.datetime.now().strftime('%Y%m%d%H%M%S')))
        if os.path.exists(appPath):
            os.rename(appPath, newPath)
            if not os.path.exists(dirPublishInstall):
                os.makedirs(dirPublishInstall)
            shutil.copy(newPath, dirPublishInstall)

    utils.printSplit("完成打包（%s）" % cfgChannel["name"])


    # clear & restore
    # utils.cleanDir(dirSdkTemp,[])
    # utils.restoreFile(backupFileList)
    # utils.restoreFile(backupAllFileList)

    utils.printSplit("脚本执行结束")

if __name__ == "__main__":
    utils.runMain(main)
