#!/usr/bin/env python
# coding=utf-8

import os
import platform
import re
import utils
import sys
import getopt
import shutil
from distutils.version import LooseVersion
from argparse import ArgumentParser

def main(cfgFile=None):
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-p", "--path",  dest="path")
    parser.add_argument("-o", "--out", dest="out")
    parser.add_argument("-d", "--develop", dest="develop")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # publish/tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # publish/xgame
    dirProject          = os.path.join(dirScript, "..", "..", "xgame")
    # client
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    # publish/xgame/package
    dirPackage          = os.path.join(dirProject, "package")
    # publish/xgame/package/src
    dirPackageSrc       = os.path.join(dirPackage, "src", "temp")
    dirPackageSrc32     = os.path.join(dirPackage, "src", "bit32")
    dirPackageSrc64     = os.path.join(dirPackage, "src", "bit64")
    # publish/xgame/package/res
    dirPackageRes       = os.path.join(dirPackage, "res")
    # publish/xgame/audio
    dirAudio            = os.path.join(dirProject, "audio")
    # publish/tools/config
    dirConfig           = os.path.join(dirScript, "..", "config")

    if args.path != None:  #命令行中参数权限最高
        dirClient = args.path

    # dirPublish = os.path.join(args.out, args.config)
    if args.develop != None and args.develop.lower() == "true":
        dirProjectRes = os.path.join(dirClient, "trunk",args.config)
        dirPublish = os.path.join(args.out, "trunk", args.config)
        print(dirProjectRes)
    else:
        dirProjectRes = os.path.join(dirClient, "tags", args.config)
        dirPublish = os.path.join(args.out, "tags", args.config)
        print(dirProjectRes)



    #
    cfgPackExt = "assets"

    # 清理文件夹
    utils.printSplit("清理文件夹")
    utils.removeFile("%s.%s" % (dirPackage, cfgPackExt))
    utils.cleanDir(dirPackage,[])
    utils.cleanDir(dirAudio,[])


    # 更新svn
    utils.printSplit("更新svn")
    cmd = "svn revert --depth infinity %s" % (dirProjectRes)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)
    
    svnInfo = utils.getSVNInfo()
    cmd = "svn update --accept theirs-full --username %s --password %s %s" % (svnInfo["n"], svnInfo["p"], dirProjectRes)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    cmd = "svn status %s" % (dirProjectRes)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

     

    # 拷贝资源到xgame/package
    utils.printSplit("拷贝资源")
    print("copy src files...")
    utils.copyDir(os.path.join(dirProjectRes, "cocosstudio", "src"), dirPackageSrc)
    print("copy res files...")
    utils.copyDir(os.path.join(dirProjectRes, "cocosstudio", "res"), dirPackageRes)
    print("copy audio files...")
    utils.copyDir(os.path.join(dirProjectRes, "cocosstudio", "audio"), dirAudio)


    backupFileList = list()

    # 编译lua 32
    utils.printSplit("编译Lua字节码")
    output = utils.luacompile(dirPackageSrc, dirPackageSrc32, True, False)
    print(output)
    # 编译lua 64
    output = utils.luacompile(dirPackageSrc, dirPackageSrc64, True, True)
    print(output)
    utils.removeDir(dirPackageSrc)

    # 打包资源
    utils.printSplit("打包资源")
    # output = utils.PackFile(dirPackage, True, True, True, cfgPackExt)
    output = utils.PackFileUpdate(dirPackage, True, True, True, cfgPackExt)
    print(output)

    #清理xiyou/package文件夹
    utils.cleanDir(dirPackage,[])

    utils.printSplit("脚本执行结束")

    # dirPublish = os.path.join(args.out, args.config)
    utils.mkOutDir(dirPublish, True, [])
    utils.copyDir(dirProjectRes, dirPublish)
    utils.cleanDir(os.path.join(dirPublish, "cocosstudio"),["simulator"])
    utils.removeDir(os.path.join(dirPublish, ".svn"))
    shutil.copy(("%s.%s" % (dirPackage, cfgPackExt)), os.path.join(dirPublish, "cocosstudio", "package.assets"))

if __name__ == "__main__":
    utils.runMain(main)
