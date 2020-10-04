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


def main(cfgFile=None):
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
    #
    dirChannel         = "/Users/wgame/Documents/SuperSDK"

    # 获取命令行参数
    optConfig, optPath, optOut  = utils.getOptions()

    cfgFile, cfgName, cfgFilePath    = utils.getConfigJson(dirConfig, optConfig)

    cfgApp              = cfgFile["app"]
    cfgUrl              = cfgFile["url"]
    cfgBuild            = cfgFile["build"]
    cfgChannel         = cfgFile["channel"]["android"]
    cfgChannelList     = cfgChannel["list"]
    cfgVersionList      = cfgFile["version"]
    cfgNewVersion       = cfgFile["version"][-1]

    if cfgChannel.has_key("version"):
        for version in cfgVersionList:
            if version["name"] == cfgChannel["version"]:
                cfgNewVersion = version
                break

    cfgShare = "android"
    if cfgChannel.has_key("share"):
        cfgShare = cfgChannel["share"]

    if cfgBuild["mode"] == "release":
        dirRuntime = os.path.join(dirScript, "..", "..", "xgame", "publish", "android")


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
    utils.modifyAppDelegate(backupFileList, os.path.join(dirProjectFramework, "runtime-src/Classes/AppDelegate.cpp"),
        utils.getuuid(cfgBuild["package"]["key"]), cfgChannel["bugly"], cfgApp["run"]
    )

    # android
    utils.printSplit("修改游戏名")
    filename = os.path.join(dirProjectFramework, "runtime-src/proj.android/res/values/strings.xml")
    utils.modifyFile(backupFileList, filename, lambda f, line:
        f.write(re.sub("[\s\t]*<string name=\"app_name\">.*</string>",
                    "    <string name=\"app_name\">%s</string>" % cfgApp["name"], line))
    )
    utils.printFile(filename, "strings.xml")

    #
    #utils.cleanDir(dirPublish,[])
    utils.cleanDir(dirSdkTemp,[])
    utils.copyDir(os.path.join(dirSdk, "android"), dirSdkTemp)

    #
    utils.printSplit("修改build-cfg.json")
    filename = os.path.join(dirProjectFramework, "runtime-src/proj.android/build-cfg.json")
    build_cfg = json.load(open(filename, 'r'))

    build_cfg["key_store"] = cfgChannel["keystore"]["file"]
    build_cfg["key_store_pass"] = cfgChannel["keystore"]["psw"]
    build_cfg["alias"] = cfgChannel["alias"]["name"]
    build_cfg["alias_pass"] = cfgChannel["alias"]["psw"]

    #copy_resources = build_cfg["copy_resources"]
    #copyItem = {}
    #copyItem["from"] = ("../../../sdk/config")
    #copyItem["to"] = ""
    #copy_resources.append(copyItem)
    #copyShare = {}
    #copyShare["from"] = ("../../../../share/%s" % cfgShare)
    #copyShare["to"] = ""
    #copy_resources.append(copyShare)

    json.dump(build_cfg, open(filename, "w"), indent=4)

    utils.printFile(filename, "build-cfg.json")

    
    #
    utils.printSplit("修改应用包名和版本号")
    filename = os.path.join(dirProjectFramework, "runtime-src/proj.android/AndroidManifest.xml")
    if cfgChannel.has_key("manifest"):
        manifest = os.path.join(dirProjectFramework, "runtime-src/proj.android/manifest/%s.xml" % cfgChannel["manifest"])
        shutil.copy(manifest, filename)
    
    utils.modifyFile(backupFileList, filename, lambda f, line:
        f.write(re.sub("[\s\t]*package[\s\t]*=[\s\t]*\".*\".*",
                "           package=\"%s\"" % cfgChannel["identifier"], line))
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
        
    utils.modifyFile(backupFileList, filename, lambda f, line:
        f.write(re.sub("[\s\t]*android:versionName[\s\t]*=[\s\t]*\".*\".*",
                "           android:versionName=\"%s\"" % cfgNewVersion["name"], line))
    )
    utils.printFile(filename, "AndroidManifest.xml")


    #
    app_abi = "armeabi"
    utils.printSplit("编译安卓母包")
    if cfgChannel.has_key("abi"):
        cfgChannelAbiList = cfgChannel["abi"]
        app_abi = ':'.join(cfgChannelAbiList)

    cmd = "cocos compile -s %s -j 8 -p android -m %s --ap %s --app-abi %s --compile-script 0" % (dirProject, cfgBuild["mode"], cfgChannel["ap"], app_abi)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    utils.restoreFile(backupFileList)


    utils.printSplit("重命名App")
    _, filepath = utils.checkFileByExtention(".apk", dirRuntime)
    appPath = os.path.join(dirRuntime, filepath)
    newPath = os.path.join(dirRuntime, "%s_%s_%s_%s.apk" % (cfgApp["file"], cfgNewVersion["name"], cfgBuild["mode"], cfgChannel["identifier"]))
    if os.path.exists(appPath):
        os.rename(appPath, newPath)
    
        #
        #sdk = ""
        #for channel in cfgChannelList:
        #    if len(sdk) > 0:
        #        sdk = "%s|%s" % (sdk, channel["sdk"])
        #    else:
        #        sdk = channel["sdk"]
        # 
        #if len(sdk) > 0:
        #    _, filepath = utils.checkFileByExtention(".apk", dirRuntime)
        #    appPath = os.path.join(dirRuntime, filepath)
        #    utils.printSplit("打包渠道包")
        #    cmd = "%s p %s %s -pn \"%s\" -s %s -o %s" % (os.path.join(dirChannel, "SuperSDK_Mac"), cfgChannel["id"], cfgChannel["secret"], sdk, appPath, dirRuntime)
        #    print(cmd)
        #    output = os.popen(cmd).read()
        #    print(output)
    
    # copy
    if optOut != "":
        dirPublish = os.path.join(optOut, cfgName, "android", datetime.datetime.now().strftime('%Y%m%d%H%M%S'))
        utils.cleanDir(dirPublish,[])
        utils.copyDir(dirRuntime, dirPublish)

    utils.printSplit("脚本执行结束")


if __name__ == "__main__":
    utils.runMain(main)
