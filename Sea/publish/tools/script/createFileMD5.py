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
import sys
import getopt
from distutils.version import LooseVersion
from argparse import ArgumentParser

def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-p", "--project", dest="project")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "vermd5")
    dirProjectMD5       = os.path.join(dirMD5, args.config)

    # 读取配置
    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)
    cfgPackExt          = "assets"
    cfgUrl              = cfgFileVersion["url"]
    cfgNewVersion       = cfgFileVersion["version"][-1]
    cfgVersionList      = cfgFileVersion["version"]

    utils.mkOutDir(dirProjectMD5, False)

    svnInfo = utils.getSVNInfo()
    
    dirSubPath = ["audio", "src", "res"]
    for version in cfgVersionList:
        dirProjectCCS = os.path.join(args.project, "cocosstudio")
        if version["path"] != "trunk":
            dirProjectCCS = os.path.join(args.project, version["path"], "cocosstudio")
        #处理smart热更dev的情况
        if version["path"] == "smart":
            dirProjectCCS = os.path.join(args.project,"..","tags", version["path"], "cocosstudio")

        fileVersionMD5 = os.path.join(dirProjectMD5, "%s_%s.md5" %(version["name"], version["svn"]))
        if not os.path.exists(fileVersionMD5):
            jsonAssets = {}
            #
            cmd = "svn update --username %s --password %s -r %s %s" % (svnInfo["n"], svnInfo["p"], version["svn"], dirProjectCCS)
            print(cmd)
            output = os.popen(cmd).read()

            #
            for subPath in dirSubPath:
                jsonSub = {}
                jsonAssets[subPath] = jsonSub
                for dirpath, dirnames, filenames in os.walk(os.path.join(dirProjectCCS, subPath)):
                    for filename in filenames:
                        fpath = os.path.join(dirpath, filename)
                        md = hashlib.md5()
                        md.update(open(fpath).read())
                        filemd5 = md.hexdigest()
                        print(os.path.relpath(fpath, os.path.join(dirProjectCCS, subPath)), filemd5)
                        jsonSub[os.path.relpath(fpath, os.path.join(dirProjectCCS, subPath))] = filemd5
                
            json.dump(jsonAssets, open(fileVersionMD5, "w"), indent=4)

    # commit
    cmd = "svn status %s" % os.path.abspath(dirProjectMD5)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)
    svnLines = output.splitlines()
    for v in svnLines:
        filePath = v[8:]
        if v.find("!",0,7) != -1:
            cmd = "svn delete %s" % filePath
            print(cmd)
            os.popen(cmd)

        if v.find("?",0,7) != -1:
            cmd = "svn add %s" % filePath
            print(cmd)
            os.popen(cmd)


    cmd = "svn commit --username %s --password %s -m \"提交md5文件\" %s" % (svnInfo["n"], svnInfo["p"], os.path.abspath(dirProjectMD5))
    print(cmd)
    output = os.popen(cmd).read()
    print(output)



    utils.printSplit("脚本执行结束")
    
if __name__ == "__main__":
    utils.runMain(main)
