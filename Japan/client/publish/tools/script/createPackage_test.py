#!/usr/bin/env python
# coding=utf-8

import os
import platform
import re
import utils
import sys
import getopt
from distutils.version import LooseVersion
from argparse import ArgumentParser

def removeInvalidDir(lang, copyRes, dirRes): 
    i18n_lang = "i18n/" + lang + "/"
    i18n_base = "i18n/base/"
    file_list = os.listdir(dirRes)
    for f in file_list:
        full_path = os.path.join(dirRes, f)
        if platform.system() == "Windows":
                full_path = full_path.replace('\\', '/')
                copyRes = copyRes.replace('\\', '/')


        if os.path.isdir(full_path):
            removeInvalidDir(lang, copyRes, full_path)
        elif os.path.isfile(full_path) and full_path.find(i18n_lang) != -1: 
            base_path = full_path.replace(i18n_lang, i18n_base)  
            if os.path.exists(base_path): 
                relpath = os.path.join(copyRes, base_path.split("/res/")[1])
                relpath = relpath.replace('\\', '/')
                print("remove base File  : " + base_path + "-- new file : " + relpath)
                print("--------------") 
                if not os.path.exists(os.path.split(relpath)[0]):
                    os.makedirs(os.path.split(relpath)[0])
                utils.copyFile(base_path, os.path.split(relpath)[0])
                utils.removeFile(base_path)
             
            res_path = full_path.replace(i18n_lang, "")  
            if os.path.exists(res_path):     
                relpath = os.path.join(copyRes, res_path.split("/res/")[1])
                relpath = relpath.replace('\\', '/')
                print("remove res File  : " + res_path)
                print("--------------")
                if not os.path.exists(os.path.split(relpath)[0]):    
                    os.makedirs(os.path.split(relpath)[0])
                utils.copyFile(res_path, os.path.split(relpath)[0]) 
                utils.removeFile(res_path)    
                
        elif os.path.isfile(full_path) and full_path.find(i18n_base) != -1:   
            res_path = full_path.replace(i18n_base, "")  
            if os.path.exists(res_path):    
                relpath = os.path.join(copyRes, res_path.split("/res/")[1])
                relpath = relpath.replace('\\', '/')
                print("remove res File by base : " + res_path)
                if not os.path.exists(os.path.split(relpath)[0]):
                    os.makedirs(os.path.split(relpath)[0])
                utils.copyFile(res_path, os.path.split(relpath)[0]) 
                utils.removeFile(res_path)          
 

def checkNotUsedLang(lang,cfgLangList=None,cfgLang=None):
    if cfgLangList:
        return not lang in cfgLangList
    else:
        return cfgLang != lang

def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-p", "--project", dest="project")
    parser.add_argument("-v", "--version", dest="version")
    parser.add_argument("-ncc", "--nococos", dest="nococos")
    parser.add_argument("-no32", "--no32bit", dest="no32bit")
    parser.add_argument("-sp", "--subpackage", dest="subpackage")
    parser.add_argument("-ap", "--audiopatch", dest="audiopatch")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # publish/tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # publish/xgame
    dirProject          = os.path.join(dirScript, "..", "..", "xgame")
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
    # 是否删除语音分包资源
    isAudioPatch        = False
    if args.audiopatch != None and args.audiopatch.lower() != "false":
        isAudioPatch    = True
    # publish/tools/config
    dirConfig           = os.path.join(dirScript, "..", "config")

    dirClient           = args.project

    # # 渠道和语言不一致时，更改为渠道为语言
    # if cfgLangList and not cfgLang in cfgLangList:    
    #     cfgLang = cfgLangList[0]

    # if not cfgLangList:
    #     cfgLangList = [cfgChannel]  

    # 清理文件夹
    #utils.printSplit("清理文件夹")
    #utils.removeFile("%s.%s" % (dirPackage, cfgPackExt))
    #utils.removeFileWithKey(dirProject,cfgPackExt,False)
    #utils.cleanDir(dirPackage,[])
    #utils.cleanDir(dirAudio,[])


    # 更新svn
    #utils.printSplit("更新svn")
    #cmd = "svn revert --depth infinity %s" % (dirProjectCCS)
    #print(cmd)
    #output = os.popen(cmd).read()
    #print(output)
    
    #svnInfo = utils.getSVNInfo()
    #cmd = "svn update --accept theirs-full --username %s --password %s -r %s %s" % (svnInfo["n"], svnInfo["p"], cfgNewVersion["svn"], dirClient)
    #print(cmd)
    #output = os.popen(cmd).read()
    #print(output)

    #cmd = "svn status %s" % (dirProjectCCS)
    #print(cmd)
    #output = os.popen(cmd).read()
    #print(output)

    dirPackageRes = "E:/SGS/Japan/client/tags/2.14.0/cocosstudio/res"
    dirResI18n = os.path.join(dirPackageRes,"i18n")
    dirResJa = os.path.join(dirResI18n,"ja")
    dirResBase = os.path.join(dirResI18n,"base")
    copyRes = os.path.join(dirPackageRes, "..", "..", "copyRes")

    removeInvalidDir("ja", copyRes, dirResJa)
    removeInvalidDir("ja", copyRes, dirResBase)

    # args.no32bit = "true"
    #utils.printSplit("编译Lua字节码")
    #if args.nococos != None and args.nococos.lower() != "false":
        # 编译lua 32
    #    if args.no32bit == None or args.no32bit.lower() != "true":
    #        output = utils.luacompileNew(dirPackageSrc, dirPackageSrc32, True, False)
        # 编译lua 64
    #    output = utils.luacompileNew(dirPackageSrc, dirPackageSrc64, True, True)
    #else:
    #    if args.no32bit == None or args.no32bit.lower() != "true":
    #        output = utils.luacompile(dirPackageSrc, dirPackageSrc32, True, False)
    #        print(output)
        # 编译lua 64
    #    output = utils.luacompile(dirPackageSrc, dirPackageSrc64, True, True)
    #    print(output)
    #utils.removeDir(dirPackageSrc)

    # 打包资源
    #utils.printSplit("打包资源")
    #isSubpackage = args.subpackage == None or args.subpackage.lower() != "false"
    #if isSubpackage:
    #    output = utils.PackFile(dirPackage, dirProject, True, True, True, "package.assets", "100")
    #else:
    #    output = utils.PackFileUpdate(dirPackage, True, True, True, cfgPackExt)
    #    pass
    #print(output)

    #清理package文件夹
    #utils.cleanDir(dirPackage,[])

    utils.printSplit("脚本执行结束")



if __name__ == "__main__":
    utils.runMain(main)
