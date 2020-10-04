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

def main(cfgFile=None):
    # tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    dirProject          = os.path.join(dirClient, "cocosstudio")

    # tools/lang 写入多语言比较
    dirLang = os.path.join(dirScript, "..", "..", "lang")

    baseLang = "cn"

    # 获取命令行参数
    optConfig, optPath, _  = utils.getOptions()
    # if optPath != "":
        # dirClient = optPath

    print("dirClient: " + dirClient)

    # 读取配置
    cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optConfig)
    cfgPackExt          = "assets"
    cfgApp              = cfgFile["app"]
    cfgBuild            = cfgFile["build"]
    cfgLang             = cfgFile["build"]["lang"] if cfgBuild.has_key("lang") else baseLang
    cfgNewVersion       = cfgFile["version"][-1]
    cfgVersionList      = cfgFile["version"]

    dirProjectMD5 = os.path.join(dirMD5, cfgName)
    utils.mkOutDir(dirProjectMD5, False)

    svnInfo = utils.getSVNInfo()

    dirSubPath = ["csui"]
    for version in cfgVersionList:
        dirProject = os.path.join(dirClient, "cocosstudio")
        if version["path"] != "trunk":
            dirProject = os.path.join(dirClient, version["path"], "cocosstudio")
        fileVersionMD5 = os.path.join(dirProjectMD5, "%s_%s.md5" %(version["name"], version["svn"]))
        
        # 更新svn
        # utils.printSplit("更新svn")
        # cmd = "svn revert --depth infinity %s" % (dirProject)
        # print(cmd)
        # output = os.popen(cmd).read()
        # print(output)

        # 存在多语言版本
        if cfgLang != baseLang:
            dirProjectMD5 = os.path.join(dirMD5, cfgName, cfgLang)
            fileVersionMD5 = os.path.join(dirProjectMD5, "%s_%s.md5" %(version["name"], version["svn"]))
            # fileVersionMD5 = os.path.join(dirProjectMD5, "%s_%s_%s.md5" %(version["name"], version["svn"], cfgLang))
            utils.mkOutDir(dirProjectMD5, False)


        if not os.path.exists(fileVersionMD5):
            jsonAssets = {}
            #更新到对应版本的svn
            cmd = "svn update --username %s --password %s -r %s %s" % (svnInfo["n"], svnInfo["p"], version["svn"], dirProject)
            print(cmd)
            print("dirProject: "+dirProject)
            print("dirSubPath: " + os.path.join(dirProject, "csui"))
            # output = os.popen(cmd).read()
            for subPath in dirSubPath:
                jsonSub = {}
                jsonAssets[subPath] = jsonSub
                for dirpath, dirnames, filenames in os.walk(os.path.join(dirProject, subPath)):
                    print dirpath
                    for filename in filenames:
                        print filename
                        fpath = os.path.join(dirpath, filename)
                        print fpath
                        md = hashlib.md5()
                        md.update(open(fpath).read())
                        filemd5 = md.hexdigest()
                        print(os.path.relpath(fpath, os.path.join(dirProject, subPath)), filemd5)
                        jsonSub[os.path.relpath(fpath, os.path.join(dirProject, subPath))] = filemd5
            utils.printObject(jsonAssets, "jsonAssets:")
            json.dump(jsonAssets, open(fileVersionMD5, "w"), indent=4)
            # 删除版本
            # if os.path.exists(dirLang):
            #     utils.removeDir(dirLang)



    # commit
    cmd = "svn status %s" % os.path.abspath(dirProjectMD5)
    print(cmd)
    # output = os.popen(cmd).read()
    # print(output)
    # svnLines = output.splitlines()
    # for v in svnLines:
    #     filePath = v[8:]
    #     if v.find("!",0,7) != -1:
    #         cmd = "svn delete %s" % filePath
    #         print(cmd)
    #         os.popen(cmd)

    #     if v.find("?",0,7) != -1:
    #         cmd = "svn add %s" % filePath
    #         print(cmd)
    #         # os.popen(cmd)


    # cmd = "svn commit --username %s --password %s -m \"提交md5文件\" %s" % (svnInfo["n"], svnInfo["p"], os.path.abspath(dirProjectMD5))
    # print(cmd)
    # output = os.popen(cmd).read()
    # print(output)



    utils.printSplit("脚本执行结束")
    
if __name__ == "__main__":
    utils.runMain(main)
