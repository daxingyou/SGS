#!/usr/bin/env python
# coding=utf-8

import pexpect
import os
import sys
import utils
import getopt
import shutil

def main(cfgFile=None):
    # tools/script
    dirExec             = os.path.dirname(utils.getExecPath())
    # tools/config
    dirConfig           = os.path.join(dirExec, "..", "config")
    #
    dirPublish          = os.path.join(dirExec, "..", "..", "install", "android")

    # get args
    optionConfig = ""
    options,args = getopt.getopt(sys.argv[1:], "c:p:", ["config=","path="])
    for name, value in options:
        if name in ("-c","--config"):
            optionConfig = value
        if name in ("-p","--path"):
            dirClient = os.path.realpath(value)

    cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optionConfig)
    cfgApp = cfgFile["app"]
    cfgUrl = cfgFile["url"]
    cfgBuild = cfgFile["build"]
    cfgUpload = cfgFile["upload"]
    cfgVersion = cfgFile["version"][-1]


    cfgAppBuildMode     = cfgBuild["mode"]

    cfgIp               = cfgUpload["install"]["ip"]
    cfgPort             = cfgUpload["install"]["port"]
    cfgUser             = cfgUpload["install"]["user"]
    cfgPassword         = cfgUpload["install"]["psw"]
    cfgUploadPath       = os.path.join(cfgUpload["install"]["path"], "android")

    

    print("\033[31mPath -------------------------------------------------------------------------------------------\033[34m")
    print("dirExec              = %s" % dirExec)
    print("dirConfig            = %s" % dirConfig)

    print("\033[31mConfig -----------------------------------------------------------------------------------------\033[34m")
    print("cfgFile              = %s.ini" % cfgName)
    print("cfgAppBuildMode      = %s" % cfgAppBuildMode)
    print("cfgIp                = %s" % cfgIp)
    print("cfgPort              = %s" % cfgPort)
    print("cfgUser              = %s" % cfgUser)
    print("cfgPassword          = %s" % cfgPassword)
    print("cfgUploadPath        = %s" % cfgUploadPath)

    # 
    print("\033[31mUpload ------------------------------------------------------------------------------------------\033[34m")
    files = utils.getFilesWithExt(dirPublish, ".apk")
    for apkFile in files:
        # upload
        cmd = "scp -o StrictHostKeyChecking=no -P %s -r %s %s@%s:%s" % (cfgPort, apkFile, cfgUser, cfgIp, cfgUploadPath)
        print(cmd)
        child = pexpect.spawn(cmd, timeout=3000)
        child.logfile = sys.stdout
        index = child.expect([".*Password:", ".*password:", pexpect.EOF, pexpect.TIMEOUT])
        if index == 0 or index == 1:
            child.sendline(cfgPassword)
            child.expect([pexpect.EOF, pexpect.TIMEOUT])
        else:
            print("error", index)



    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")
    
if __name__ == '__main__':
    utils.runMain(main)
