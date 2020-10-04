#!/usr/bin/env python
# coding=utf-8

import os
import platform
import re
import utils
import shutil
import json
import sys
import getopt
import datetime
from distutils.version import LooseVersion
from argparse import ArgumentParser
import ndkGradleAntBuild


def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-a", "--app", dest="app")
    parser.add_argument("-o", "--outPath", dest="outPath")
    parser.add_argument("-v", "--version", dest="version")
    parser.add_argument("-t", "--target", dest="target")
    parser.add_argument("-cp", "--channelPath", dest="channelPath")
    parser.add_argument("-obb", "--androidObb", dest="androidObb")
    parser.add_argument("-cpb", "--compatible", dest="compatible")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # publish/tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # publish/xgame
    dirProject          = os.path.join(dirScript, "..", "..", "xgame")
    # publish/xgame/frameworks
    dirProjectFramework = os.path.join(dirProject, "frameworks")
    # publish/tools/config
    dirConfig           = os.path.join(dirScript, "..", "config")
    # publish/xgame/runtime/android
    dirRuntime          = os.path.join(dirScript, "..", "..", "xgame", "simulator", "android")
    # publish/xgame/sdk
    dirSdkTemp          = os.path.join(dirProject, "sdk")
    # publish/sdk
    dirSdk              = os.path.join(dirScript, "..", "..", "sdk")
    # publish/install
    dirPublish          = os.path.join(dirScript, "..", "..", "install")

    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)
    cfgFileApp          = utils.getAppConfig(dirConfig, args.config, args.app)
    cfgApp              = cfgFileApp["app"]
    cfgChannel          = cfgApp["android"]
    cfgUrl              = cfgFileVersion["url"]
    cfgVersionList      = cfgFileVersion["version"]
    cfgNewVersion       = cfgFileVersion["version"][-1]
    cfgBuildMode        = "release"

    # 国际化配置
    cfgI18n             = cfgFileApp["i18n"] if cfgFileApp.has_key("i18n") else {} 
    cfgUseObb           = cfgI18n["obb"] if cfgI18n.has_key("obb") else False 

    if args.androidObb != None:  #命令行中参数权限最高
        if args.androidObb.lower() == "false":
            cfgUseObb = False
        if args.androidObb.lower() == "true":
            cfgUseObb = True
    print("isUseObb = "+ str(cfgUseObb))

    if args.version != None and args.version != "new":
        for version in cfgVersionList:
            if version["name"] == args.version:
                cfgNewVersion = version
                break

    if cfgBuildMode == "release":
        dirRuntime = os.path.join(dirScript, "..", "..", "xgame", "publish", "android")

    # 安卓版本
    androidTarget = cfgI18n["ap"] or "android-19"
    if args.target != None:
        androidTarget = args.target


    # 更新svn
    svnInfo = utils.getSVNInfo()
    utils.printSplit("更新svn")
    cmd = "svn revert --depth infinity %s" % (dirProjectFramework)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    cmd = "svn update --accept theirs-full --username %s --password %s %s" % (svnInfo["n"], svnInfo["p"], dirProjectFramework)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    cmd = "svn status %s" % (dirProjectFramework)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    #
    backupFileList = list()
    utils.printSplit("修改AppDelegate.cpp")
    utils.modifyAppDelegate(backupFileList, os.path.join(dirProjectFramework, "runtime-src/Classes/AppDelegate.cpp"), cfgApp["run"], cfgNewVersion["path"])
    
    apversion = int(androidTarget[8:])

    cfgPackageName = "package.assets"
    # 分包
    isSubpackage = os.path.exists(os.path.join(dirProject, "%s000" % cfgPackageName))

    # 修改build-cfg.json
    utils.printSplit("修改build-cfg.json")
    filename = os.path.join(dirProjectFramework, "runtime-src/proj.android/build-cfg.json")
    build_cfg = json.load(open(filename, 'r'))

    build_cfg["key_store"] = cfgChannel["keystore"]["file"]
    build_cfg["key_store_pass"] = cfgChannel["keystore"]["psw"]
    build_cfg["alias"] = cfgChannel["alias"]["name"]
    build_cfg["alias_pass"] = cfgChannel["alias"]["psw"]

    copy_resources = build_cfg["copy_resources"]
    copyItem = {}
    copyItem["from"] = ("../../../sdk/assets")
    copyItem["to"] = ""
    copy_resources.append(copyItem)
    # json.dump(build_cfg, open(filename, "w"), indent=4)
    if cfgUseObb != True:
        copyItem = {}
        copyItem["from"] = ("../../../audio")
        copyItem["to"] = "audio"
        copy_resources.append(copyItem)
        if not isSubpackage:
            copyItem = {}
            copyItem["from"] = ("../../../%s" % cfgPackageName)
            copyItem["to"] = ""
            copy_resources.append(copyItem)
        else:  # 分包处理
            count = 0
            while True:
                assetName = "%s%03d" % (cfgPackageName,count)
                assetPath = os.path.join(dirProject, assetName)
                if not os.path.exists(assetPath):
                    break
                copyItem = {}
                copyItem["from"] = ("../../../%s" % assetName)
                copyItem["to"] = ""
                copy_resources.append(copyItem)
                count = count+1
            pass        

    json.dump(build_cfg, open(filename, "w"), indent=4)
    utils.printFile(filename, "build-cfg.json")

    # 确定 Android app_abi
    app_abi = "armeabi"
    if cfgChannel.has_key("abi"):
        cfgChannelAbiList = cfgChannel["abi"]
        if apversion <= 19 and len(cfgChannelAbiList) > 1:
            app_abi = cfgChannelAbiList[0]
        else:
            app_abi = ':'.join(cfgChannelAbiList)

    # 采用兼容模式打包
    # if args.compatible != None and args.compatible != "false" and apversion > 19:
    #     utils.printSplit("兼容模式编译母包")
    #     cmd = "cocos compile -s %s -j 8 -p android -m %s --ap %s --app-abi %s --compile-script 0" % (dirProject, cfgBuildMode, "android-19", app_abi)
    #     print(cmd)
    #     output = os.popen(cmd).read()
    #     print(output)

    
    utils.printSplit("修改android版本 =  %s" % androidTarget)

    if androidTarget == "android-26" or apversion > 26:
        utils.printSplit("copy android26 src目录内容到 android build runtime。 target android version = %s" % androidTarget)
        # utils.copyDir(os.path.join(dirProjectFramework, "runtime-src/proj.android26/"), os.path.join(dirProjectFramework, "runtime-src/proj.android/"))
        utils.copyDir(os.path.join(dirProjectFramework, "runtime-src/proj.android26/src"), os.path.join(dirProjectFramework, "runtime-src/proj.android/src"))
        shutil.copy(os.path.join(dirProjectFramework, "runtime-src/proj.android26/AndroidManifest.xml"), os.path.join(dirProjectFramework, "runtime-src/proj.android/AndroidManifest.xml"))
    
    # android
    utils.printSplit("修改游戏名")
    filename = os.path.join(dirProjectFramework, "runtime-src/proj.android/res/values/strings.xml")
    utils.modifyFile(backupFileList, filename, lambda f, line:
    f.write(re.sub("[\s\t]*<string name=\"app_name\">.*</string>",
    "    <string name=\"app_name\">%s</string>" % cfgApp["name"], line))
    )
    utils.printFile(filename, "strings.xml")

    # top_server
    if cfgI18n.has_key("top_server"):
        utils.printSplit("修改topserver地址 = %s" % cfgI18n["top_server"])
        nativeAgentFileName = os.path.join(dirProjectFramework, "runtime-src/proj.android/src/org/cocos2dx/sdk/NativeAgent.java")
        utils.modifyFile(backupFileList,nativeAgentFileName, lambda f, line:
            f.write(re.sub("[\s\t]*String TOP_SERVER_URL[\s\t]*=[\s\t]*\".*\".*",
        "					String TOP_SERVER_URL = \"%s\";" % cfgI18n["top_server"], line))
        )

    #
    #utils.cleanDir(dirPublish,[])

    backupFileList = list()
    manifestFileName = os.path.join(dirProjectFramework, "runtime-src/proj.android/AndroidManifest.xml")
    utils.backUpFile(backupFileList, manifestFileName)
    buildcfgFileName = os.path.join(dirProjectFramework, "runtime-src/proj.android/build-cfg.json")
    utils.backUpFile(backupFileList, buildcfgFileName)

    files = {}
    for dirpath, dirnames, filenames in os.walk(os.path.join(dirProjectFramework, "runtime-src", "proj.android")):
        for filename in filenames:
            files[dirpath + filename] = True


    utils.printSplit("开始打包（%s）" % cfgChannel["name"])
    cfgAppPackage   = cfgChannel["identifier"]

    # 拷贝当前渠道sdk文件
    for dirpath, dirnames, filenames in os.walk(os.path.join(dirProjectFramework, "runtime-src", "proj.android")):
        for filename in filenames:
            if files.has_key(dirpath + filename) != True:
                utils.removeFile(dirpath + filename)

    utils.cleanDir(dirRuntime,[])
    utils.restoreFile(backupFileList)
    utils.cleanDir(dirSdkTemp,[])
    utils.copyDir(os.path.join(dirSdk, "android", cfgChannel["sdk"]), dirSdkTemp)

    # 拷贝res、libs
    utils.copyDir2(os.path.join(dirSdkTemp, "libs"), os.path.join(dirProjectFramework, "runtime-src", "proj.android", "libs"))
    utils.copyDir2(os.path.join(dirSdkTemp, "res"), os.path.join(dirProjectFramework, "runtime-src", "proj.android", "res"))

    utils.printSplit("处理AndroidManifest")
    utils.modifyFile1(manifestFileName, lambda f, line:
    f.write(re.sub("[\s\t]*package[\s\t]*=[\s\t]*\".*\".*",
            "           package=\"%s\"" % cfgAppPackage, line))
    )
    
    if cfgNewVersion.has_key("build"):
        utils.modifyFile1(manifestFileName, lambda f, line:
        f.write(re.sub("[\s\t]*android:versionCode[\s\t]*=[\s\t]*\".*\".*",
                "           android:versionCode=\"%s\"" % cfgNewVersion["build"], line))
        )
    else:
        utils.modifyFile1(manifestFileName, lambda f, line:
        f.write(re.sub("[\s\t]*android:versionCode[\s\t]*=[\s\t]*\".*\".*",
                "           android:versionCode=\"%s\"" % cfgNewVersion["svn"], line))
        )
    
    utils.modifyFile1(manifestFileName, lambda f, line:
        f.write(re.sub("[\s\t]*android:versionName[\s\t]*=[\s\t]*\".*\".*",
                "           android:versionName=\"%s\"" % cfgNewVersion["name"], line))
    )

    if apversion > 19:
        utils.modifyFile1(manifestFileName, lambda f, line:
            f.write(re.sub("[\s\t]*android:targetSdkVersion[\s\t]*=[\s\t]*\".*\".*",
                    "           android:targetSdkVersion=\"%s\"" % apversion+"", line))
        )
    
    # 合并AndroidManifest
    utils.mergeManifest(manifestFileName, os.path.join(dirSdk, "android", cfgChannel["sdk"], "info", "SDKManifest.xml"))

    #
    utils.printFile(manifestFileName, "AndroidManifest.xml")

    #obb文件包含 package.assets或package.assets000...分包 和 audio目录中的音频 start.mp4
    # zip -1 -rn .assets:.ogg:.mp3:.wav main.1019.com.sanguosha.mjz.obb ./
    if cfgUseObb == True and (os.path.exists(os.path.join(dirProject, cfgPackageName)) or isSubpackage):
        print("obbFileName: main.%s.%s.obb" % (cfgNewVersion["svn"],cfgAppPackage))
        obbPackageName = "main.%s.%s.obb" % (cfgNewVersion["svn"],cfgAppPackage)
        dirObb = os.path.join(dirProject, cfgAppPackage)

        obbPackagePath = os.path.join(dirObb, "package")
        utils.mkOutDir(dirObb,1)
        utils.mkOutDir(obbPackagePath,1)

        suffix = ""
        if not isSubpackage:
            shutil.copy(os.path.join(dirProject,cfgPackageName), os.path.join(obbPackagePath, cfgPackageName))
        else:# package分包处理
            count = 0
            while True:
                packageName = "%s%03d" % (cfgPackageName,count)
                suffix = suffix + ":.assets%03d" % count
                obbSourceFile = os.path.join(dirProject, packageName)
                obbPackageFile = os.path.join(obbPackagePath, packageName)
                if not os.path.exists(obbSourceFile):
                    break
                shutil.copy(obbSourceFile, obbPackageFile)
                count = count+1
            pass

        # 资源处理
        utils.copyDir(os.path.join(dirProject, "audio"),os.path.join(dirObb,"assets","audio"))
        if os.path.exists(os.path.join(dirSdkTemp, "assets", "start.mp4")):
            shutil.move(os.path.join(dirSdkTemp, "assets", "start.mp4"),os.path.join(dirObb,"assets","start.mp4"))
        cmd = " cd %s && pwd && zip -1 -rn .assets:.ogg:.mp3:.wav:.mp4%s %s ./  && cd %s && pwd " % (dirObb,suffix,obbPackageName,dirScript)
        print(cmd)
        output = os.popen(cmd).read()
        print(output)
        if os.path.exists(os.path.join(dirRuntime, cfgAppPackage)):
            utils.removeDir(os.path.join(dirRuntime, cfgAppPackage))
        utils.mkOutDir(os.path.join(dirRuntime, cfgAppPackage),1)
        shutil.move(os.path.join(dirObb, obbPackageName), os.path.join(dirRuntime, cfgAppPackage))
        if os.path.exists(dirObb):
            utils.removeDir(dirObb)

    utils.printSplit("编译安卓母包")
    # cmd = "cocos compile -s %s -j 8 -p android -m %s --ap %s --app-abi %s --compile-script 0" % (dirProject, cfgBuildMode, androidTarget, app_abi)
    # print(cmd)
    # output = os.popen(cmd).read()
    # print(output)

    #兼容低端机，bCompatible==True，ndk先编译android-19再根据androidTarget编译，bCompatible==False，ndk只根据androidTarget编译
    bCompatible = False
    if args.compatible != None and args.compatible.lower() != "false" and apversion > 19:
        bCompatible = True
    bAndroidStudio = False
    ndkGradleAntBuild.startBuild(cfgBuildMode, androidTarget, app_abi, bAndroidStudio, bCompatible)

    utils.printSplit("重命名App")
    dirPublishInstall = args.outPath
    _, filepath = utils.checkFileByExtention(".apk", dirRuntime)
    appPath = os.path.join(dirRuntime, filepath)
    newPath = os.path.join(dirRuntime, "%s_%s_%s_%s_%s.apk" % (cfgApp["file"], cfgNewVersion["name"], cfgBuildMode, cfgAppPackage, datetime.datetime.now().strftime('%Y%m%d%H%M%S')))
    if os.path.exists(appPath):
        os.rename(appPath, newPath)
        utils.mkOutDir(dirPublishInstall,1)
        utils.printSplit("app移动到指定目录")
        print(dirPublishInstall)
        shutil.copy(newPath, dirPublishInstall)

    dirDefaultChannelPath = os.path.join(dirPublishInstall,"..", "apk_channel")
    if os.path.exists(dirDefaultChannelPath) and os.path.exists(os.path.join(dirDefaultChannelPath,cfgAppPackage)):
        utils.removeDir(os.path.join(dirDefaultChannelPath,cfgAppPackage))
        
    if cfgUseObb == True:
        utils.printSplit("处理obb文件")
        utils.mkOutDir(dirPublishInstall,1)
        shutil.copy(newPath, dirPublishInstall)
        utils.copyDir(os.path.join(dirRuntime, cfgAppPackage), os.path.join(dirPublishInstall,cfgAppPackage))

        utils.printSplit("copy obb文件到 channel path")
        dirChannelPath = args.channelPath
        if dirChannelPath != None:
            utils.mkOutDir(dirChannelPath,1)
            utils.copyDir(os.path.join(dirRuntime, cfgAppPackage), os.path.join(dirChannelPath,cfgAppPackage))
        else:    
            # utils.mkOutDir(dirDefaultChannelPath,1)
            utils.copyDir(os.path.join(dirRuntime, cfgAppPackage), os.path.join(dirDefaultChannelPath,cfgAppPackage))




    utils.printSplit("完成打包（%s）" % cfgChannel["name"])


    utils.printSplit("脚本执行结束")


if __name__ == "__main__":
    utils.runMain(main)
