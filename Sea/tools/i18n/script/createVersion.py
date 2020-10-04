#!/usr/bin/env python
# coding=utf-8

import os
import zipfile
import hashlib
import platform
import re
import StringIO
import collections
import shutil
import utils
import json
import struct
from distutils.version import LooseVersion

def main(cfgFile=None):
    # tools/script
    dirExec             = os.path.dirname(utils.getExecPath())
    # develop
    dirProject          = os.path.join(dirExec, "..", "..", "cocosstudio")
    # tools/config
    dirConfig           = os.path.join(dirExec, "..", "config")

    dirScript           = os.path.dirname(utils.getExecPath())
    # dirConfig           = os.path.join(dirScript, "..", "config")
    # dirMD5              = os.path.join(dirScript, "..", "md5")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    # dirProject          = os.path.join(dirClient, "cocosstudio")



    # 获取命令行参数
    optConfig, optPath, _  = utils.getOptions()
    if optPath != "":
        dirClient = optPath


    cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optConfig)

    cfgNewVersion       = cfgFile["version"][-1]
    cfgVersionList      = cfgFile["version"]

    if cfgNewVersion["path"] == "trunk":
        dirProject = os.path.join(dirClient, "cocosstudio")
    else:
        dirProject = os.path.join(dirClient, cfgNewVersion["path"], "cocosstudio")

    # version
    cfgVerMaxRes        = cfgNewVersion["name"]

    svnInfo = utils.getSVNInfo()

    verList = cfgVerMaxRes.split('.')
    print verList
    if int(verList[2])+1 > 99:
        verList[2] = "0"
        if int(verList[1])+1 > 99:
            verList[1] = "0"
            verList[0] = str(int(verList[0]) + 1)
        else:
            verList[1] = str(int(verList[1]) + 1)
    else:
        verList[2] = str(int(verList[2]) + 1)

    cfgVerNewRes = "%s.%s.%s" %(verList[0], verList[1], verList[2])

    # update max version  获取最后的修改版本
    print("\033[31msvnversion -------------------------------------------------------------------------------------\033[34m")
    cmd = "cd %s && svnversion -c |sed 's/^.*://' |sed 's/[A-Z]*$//'" % (dirProject)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    newVersion = {}
    newVersion["name"] = cfgVerNewRes
    newVersion["svn"] = int(output)
    newVersion["path"] = cfgNewVersion["path"]
    cfgVersionList.append(newVersion)

    json.dump(cfgFile, open(cfgFilePath, "w"), ensure_ascii=False, indent=4)
    
    cmd = "svn commit --username %s --password %s -m \"%s new version = %s:%s\" %s" % (svnInfo["n"], svnInfo["p"], cfgName, cfgVerNewRes, output, os.path.abspath(cfgFilePath))
    print(cmd)
    # output = os.popen(cmd).read()
    # print(output)


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")
    
if __name__ == "__main__":
    utils.runMain(main)
