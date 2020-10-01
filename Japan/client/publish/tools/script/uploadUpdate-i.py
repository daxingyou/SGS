#!/usr/bin/env python
# coding=utf-8

import pexpect
import os
import sys
import utils
import getopt
from distutils.version import LooseVersion
from argparse import ArgumentParser

def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-i", "--ip", dest="ip")
    parser.add_argument("-p", "--port", dest="port")
    parser.add_argument("-u", "--user", dest="user")
    parser.add_argument("-l", "--upload", dest="upload")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    #
    dirExec             = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirExec, "..", "config")

    #
    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)
    cfgVersion          = cfgFileVersion["version"][-1]
    cfgIp               = args.ip
    cfgPort             = args.port
    cfgUser             = args.user
    cfgUploadPath       = args.upload

    #
    dirPublish          = os.path.join(dirExec, "..", "..", "update")
    dirOutput           = os.path.join(dirPublish, cfgVersion["name"])
    dirTemp             = os.path.join(dirOutput, "versions")


    print("\033[31mPath -------------------------------------------------------------------------------------------\033[34m")
    print("dirExec          = %s" % dirExec)
    print("dirOutput        = %s" % dirOutput)
    print("dirConfig        = %s" % dirConfig)
    print("dirTemp          = %s" % dirTemp)

    print("\033[31mConfig -----------------------------------------------------------------------------------------\033[34m")
    print("cfgIp            = %s" % cfgIp)
    print("cfgPort          = %s" % cfgPort)
    print("cfgUser          = %s" % cfgUser)
    print("cfgUploadPath    = %s" % cfgUploadPath)

    #
    print("\033[31mUpload ------------------------------------------------------------------------------------------\033[34m")
    if not os.path.exists(dirTemp):

        # upload
        cmd = "scp -P %s -i /Users/game/.ssh/id_rsa -r %s %s@%s:%s" % (cfgPort, dirOutput, cfgUser, cfgIp, cfgUploadPath)
        print(cmd)
        child = pexpect.spawn(cmd, timeout=3000)
        child.logfile = sys.stdout
        ret = child.expect([pexpect.EOF, pexpect.TIMEOUT])
        #if ret == 0 or ret == 1:
        #    child.sendline("yes")
        #    child.expect([pexpect.EOF, pexpect.TIMEOUT])
        #else:
        #    print("error", ret)

        # cmd = "ssh -p %s %s@%s 'scp -r /data/wwwroot/* 10.105.49.112:/data/ftp_server/wwwroot/'" % (cfgPort, cfgUser, cfgIp)
        # print(cmd)
        # child = pexpect.spawn(cmd)
        # child.logfile = sys.stdout
        # ret = child.expect([pexpect.EOF, pexpect.TIMEOUT])

    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")

if __name__ == '__main__':
    utils.runMain(main)
