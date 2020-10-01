#!/usr/bin/env python
# coding=utf-8

import pexpect
import os
import sys
import utils
import getopt
from distutils.version import LooseVersion

def main(cfgFile=None):
    # tools/script
    dirExec             = os.path.dirname(utils.getExecPath())
    # tools/config
    dirConfig           = os.path.join(dirExec, "..", "config")
    #
    dirPublish          = os.path.join(dirExec, "..", "..", "update")

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

    cfgIp               = cfgUpload["update"]["ip"]
    cfgPort             = cfgUpload["update"]["port"]
    cfgUser             = cfgUpload["update"]["user"]
    cfgPassword         = cfgUpload["update"]["psw"]
    cfgUploadPath       = cfgUpload["update"]["path"]


    # tools/update
    dirOutput           = os.path.join(dirPublish, cfgVersion["name"])
    # tools/update/versions
    dirTemp             = os.path.join(dirOutput, "versions")

    #cfgUploadPath       = os.path.join(cfgUploadPath, "update")



    print("\033[31mPath -------------------------------------------------------------------------------------------\033[34m")
    print("dirExec          = %s" % dirExec)
    print("dirOutput        = %s" % dirOutput)
    print("dirConfig        = %s" % dirConfig)
    print("dirTemp          = %s" % dirTemp)

    print("\033[31mConfig -----------------------------------------------------------------------------------------\033[34m")
    print("cfgIp            = %s" % cfgIp)
    print("cfgPort          = %s" % cfgPort)
    print("cfgUser          = %s" % cfgUser)
    print("cfgPassword      = %s" % cfgPassword)
    print("cfgUploadPath    = %s" % cfgUploadPath)

    #
    print("\033[31mUpload ------------------------------------------------------------------------------------------\033[34m")
    if not os.path.exists(dirTemp):
        # clear server
        cmd = "ssh -o StrictHostKeyChecking=no -p %s %s@%s 'rm -rf %s'" % (cfgPort, cfgUser, cfgIp, cfgUploadPath)
        print(cmd)
        child = pexpect.spawn(cmd)
        child.logfile = sys.stdout
        ret = child.expect([".*Password:", ".*password:", pexpect.EOF, pexpect.TIMEOUT])
        if ret == 0 or ret == 1:
            child.sendline(cfgPassword)
            child.expect([pexpect.EOF, pexpect.TIMEOUT])
        else:
            print("error", ret)
            return

        # upload
        cmd = "scp -P %s -r %s %s@%s:%s" % (cfgPort, dirOutput, cfgUser, cfgIp, cfgUploadPath)
        print(cmd)
        child = pexpect.spawn(cmd, timeout=3000)
        child.logfile = sys.stdout
        ret = child.expect([".*Password:", ".*password:", pexpect.EOF, pexpect.TIMEOUT])
        if ret == 0 or ret == 1:
            child.sendline(cfgPassword)
            child.expect([pexpect.EOF, pexpect.TIMEOUT])
        else:
            print("error", ret)


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")

if __name__ == '__main__':
    utils.runMain(main)
