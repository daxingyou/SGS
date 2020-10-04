#!/usr/bin/env python
# coding=utf-8

import os
import platform
import re
import utils
from distutils.version import LooseVersion


def main(cfgFile=None):
    # tools/script
    dirExec             = os.path.dirname(utils.getExecPath())
    # xgame
    dirProject          = os.path.join(dirExec, "..", "..", "xgame")
    # xgame/frameworks
    dirProjectApp       = os.path.join(dirProject, "frameworks")
    # develop
    dirProjectRes       = os.path.join(dirExec, "..", "..", "develop")
    # tools/config
    dirConfig           = os.path.join(dirExec, "..", "config")
    # xgame/runtime/ios
    dirRuntimeIos       = os.path.join(dirExec, "..", "..", "xgame", "runtime", "ios")

    # config
    cfgFile, cfgName, cfgFilePath    = utils.getConfig(dirConfig)
    cfgAppBuildMode     = "release" 
    if cfgFile.has_section("test"):
        cfgAppBuildMode          = "debug" if cfgFile.getint("test", "debug") == 1 else "release" 

    cfgAppPackage       = cfgFile.get("app", "package")
    cfgAppName          = cfgFile.get("app", "name")
    cfgAppOP            = cfgFile.get("app", "op")
    cfgPackKey          = cfgFile.get("pack", "key")
    cfgPackKey          = utils.getuuid(cfgPackKey)
    cfgIosBugly         = cfgFile.get("ios", "bugly")
    cfgIosTarget        = cfgFile.get("ios", "target")
    cfgIosSign          = cfgFile.get("ios", "sign-identity")
    cfgProvisioningProfile = "" 
    if cfgFile.has_option("ios", "provisioning-profile"):
        cfgProvisioningProfile = cfgFile.get("ios", "provisioning-profile")
    cfgIosBuglyDebug        = "false"
    if cfgAppBuildMode == "debug":
        cfgIosBuglyDebug    = "true"

    cfgVerListApp       = cfgFile.options("version")
    cfgVerMaxApp        = "0.0.0"
    cfgVerListSize      = 0

    # version
    for ver in cfgVerListApp:
        cfgVerListSize = cfgVerListSize + 1
        if LooseVersion(cfgVerMaxApp) < LooseVersion(ver):
            cfgVerMaxApp = ver


    if cfgAppBuildMode == "release":
        # xgame/publish/ios
        dirRuntimeIos = os.path.join(dirExec, "..", "..", "xgame", "publish", "ios")

    #
    print("\033[31mPath -------------------------------------------------------------------------------------------\033[34m")
    print("dirExec          = %s" % dirExec)
    print("dirConfig        = %s" % dirConfig)
    print("dirProject       = %s" % dirProject)
    print("dirProjectApp    = %s" % dirProjectApp)
    print("dirProjectRes    = %s" % dirProjectRes)
    print("dirRuntimeIos    = %s" % dirRuntimeIos)

    print("\033[31mConfig -----------------------------------------------------------------------------------------\033[34m")
    print("cfgFile          = %s.ini" % cfgName)
    print("cfgAppBuildMode  = %s" % cfgAppBuildMode)
    print("cfgAppPackage    = %s" % cfgAppPackage)
    print("cfgAppName       = %s" % cfgAppName)
    print("cfgAppOP         = %s" % cfgAppOP)
    print("cfgPackKey       = %s" % cfgPackKey)
    print("cfgIosBugly      = %s" % cfgIosBugly)
    print("cfgIosTarget     = %s" % cfgIosTarget)
    print("cfgIosSign       = %s" % cfgIosSign)
    print("cfgVerListApp    = %s" % cfgVerListApp)
    print("cfgVerMaxApp     = %s" % cfgVerMaxApp)
    print("cfgVerListSize   = %s" % cfgVerListSize)


    # update max version
    print("\033[31mUpdate svn -------------------------------------------------------------------------------------\033[34m")
    cfgVerMaxSvnApp = cfgFile.get("version", cfgVerMaxApp)
    #cmd = "cd %s && svn update -r %s" % (dirProjectApp, cfgVerMaxSvnApp)
    #cmd = "cd %s && svn update" % (dirProjectApp)
    #print(cmd)
    #output = os.popen(cmd).read()

    print("\033[31mModify Files -----------------------------------------------------------------------------------\033[34m")
    backupFileList = list()
 
    utils.modifyFile(backupFileList, os.path.join(dirProjectApp, "runtime-src/Classes/AppDelegate.cpp"), lambda f, line:
                     f.write(re.sub("[\s\t]*storage->setXXTEAKey.*",
                                    "    storage->setXXTEAKey(\"%s\", strlen(\"%s\"));" % (cfgPackKey, cfgPackKey), line))
                     )

    utils.modifyFile(backupFileList, os.path.join(dirProjectApp, "runtime-src/Classes/AppDelegate.cpp"), lambda f, line:
                     f.write(re.sub("[\s\t]*CrashReport::initCrashReport.*",
                                    "    CrashReport::initCrashReport(\"%s\", %s);" % (cfgIosBugly, cfgIosBuglyDebug), line))
                     )

    filename = os.path.join(dirProjectApp, "runtime-src/proj.ios_mac/ios/Info.plist")
    utils.backUpFile(backupFileList, filename)

    dirSdkInfoPlist = os.path.join(dirProject, "sdk", "ios", cfgAppOP, "info", "info.plist")
    if os.path.exists(dirSdkInfoPlist):
        cmd = '/usr/libexec/PlistBuddy -c "Merge %s" %s'%(dirSdkInfoPlist, filename)
        os.system(cmd)

    cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleVersion %s" %s'%(cfgVerMaxApp, filename)
    os.system(cmd)
    cmd = '/usr/libexec/PlistBuddy -c "Set:CFBundleShortVersionString %s" %s'%(cfgVerMaxApp, filename)
    os.system(cmd)

    print("\033[35m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Info.plist<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
    f = open(filename, 'r')
    print f.read()
    f.close()
    print("\033[35m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Info.plist<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")



    if cfgAppOP != "wgame":
        print("\033[31mModify Xcodeproj -------------------------------------------------------------------------------\033[34m")
        # backup .pbxproj
        filename = os.path.join(dirProjectApp, "runtime-src/proj.ios_mac/wgame.xcodeproj/project.pbxproj")
        utils.backUpFile(backupFileList, filename)

        #
        cmd = "ruby %s %s %s %s %s '%s' %s" % (os.path.join(dirExec, "..", "external", "xcodeproj.rb"), os.path.abspath(dirProject), cfgIosTarget, cfgAppOP, cfgAppPackage, cfgAppName, cfgProvisioningProfile)
        print(cmd)
        output = os.popen(cmd).read()
        print(output)

        print("\033[35m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>project.pbxproj<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
        f = open(filename, 'r')
        print f.read()
        f.close()
        print("\033[35m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>project.pbxproj<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")


if __name__ == "__main__":
    utils.runMain(main)
