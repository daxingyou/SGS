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


def removeInvalidFile(lang, dirRes): 
    i18n_lang = "i18n/" + lang + "/"
    i18n_base = "i18n/base/"
    file_list = os.listdir(dirRes)
    for f in file_list:
        full_path = os.path.join(dirRes, f)
        if platform.system() == "Windows":
                full_path = full_path.replace('\\', '/')


        if os.path.isdir(full_path):
            removeInvalidFile(lang, full_path)
        elif os.path.isfile(full_path) and full_path.find(i18n_lang) != -1: 
            base_path = full_path.replace(i18n_lang, i18n_base)  
            if os.path.exists(base_path):  
                print("remove base File  : " + base_path)  
                utils.removeFile(base_path)
             
            res_path = full_path.replace(i18n_lang, "")  
            if os.path.exists(res_path):      
                print("remove res File  : " + res_path)  
                utils.removeFile(res_path)    
                
        elif os.path.isfile(full_path) and full_path.find(i18n_base) != -1:   
            res_path = full_path.replace(i18n_base, "")  
            if os.path.exists(res_path):     
                print("remove res File by base : " + res_path) 
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

    # 读取配置文件
    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)
    cfgPackExt          = "assets"
    cfgUrl              = cfgFileVersion["url"]
    cfgTest             = cfgFileVersion["test"] if cfgFileVersion.has_key("test") else None
    cfgVersionList      = cfgFileVersion["version"]
    cfgNewVersion       = cfgFileVersion["version"][-1]

    # 国际化配置
    cfgI18n             = cfgFileVersion["i18n"] if cfgFileVersion.has_key("i18n") else {} 
    # 兼容只有lang没有channel
    cfgLang             = cfgI18n["lang"] if cfgI18n.has_key("lang") else None 
    cfgChannel          = cfgI18n["channel"] if cfgI18n.has_key("channel") else None 
    cfgMatchLang        = cfgI18n["matchLang"] if cfgI18n.has_key("matchLang") else None
    cfgLangList         = None

    if args.version != None and args.version != "new":
        for version in cfgVersionList:
            if version["name"] == args.version:
                cfgNewVersion = version
                break
    # 
    if cfgNewVersion["path"] == "trunk":
        dirProjectCCS = os.path.join(dirClient, "cocosstudio")
    else:
        dirProjectCCS = os.path.join(dirClient, cfgNewVersion["path"], "cocosstudio")

    # 语音分包
    dirAudioHD          = os.path.join(dirProjectCCS,"reshd", "audio")

    # 处理多语言分支版本
    if cfgMatchLang:
        cfgLangList = utils.getMathLangList(cfgMatchLang)

    # # 渠道和语言不一致时，更改为渠道为语言
    # if cfgLangList and not cfgLang in cfgLangList:    
    #     cfgLang = cfgLangList[0]

    # if not cfgLangList:
    #     cfgLangList = [cfgChannel]  

    # 清理文件夹
    utils.printSplit("清理文件夹")
    utils.removeFile("%s.%s" % (dirPackage, cfgPackExt))
    utils.removeFileWithKey(dirProject,cfgPackExt,False)
    utils.cleanDir(dirPackage,[])
    utils.cleanDir(dirAudio,[])


    # 更新svn
    utils.printSplit("更新svn")
    cmd = "svn revert --depth infinity %s" % (dirProjectCCS)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)
    
    svnInfo = utils.getSVNInfo()
    cmd = "svn update --accept theirs-full --username %s --password %s -r %s %s" % (svnInfo["n"], svnInfo["p"], cfgNewVersion["svn"], dirClient)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    cmd = "svn status %s" % (dirProjectCCS)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

     

    # 拷贝资源到xgame/package
    utils.printSplit("拷贝资源")
    print("copy src files...")
    utils.copyDir(os.path.join(dirProjectCCS, "src"), dirPackageSrc)
    print("copy res files...")
    utils.copyDir(os.path.join(dirProjectCCS, "res"), dirPackageRes)
    print("copy audio files...")
    utils.copyDir(os.path.join(dirProjectCCS, "audio"), dirAudio)


    backupFileList = list()

    # 修改config.lua
    utils.printSplit("修改config.lua")
    utils.modifyConfigLua(backupFileList, os.path.join(dirPackageSrc, "config.lua"), 
        cfgNewVersion["name"], cfgUrl["server"], cfgUrl["gateway"], cfgUrl["config"], cfgUrl["rolelist"],cfgUrl["clientserv"]
    )

    # 修改Lang.lua
    if cfgLangList:
        utils.printSplit("修改Lang.lua的Lang.lang=%s"%cfgLangList[0])
        utils.printSplit("修改Lang.lua的Lang.channel=%s"%cfgChannel)
        utils.modifyLangLua(backupFileList, os.path.join(dirPackageSrc, "app", "lang", "Lang.lua"),cfgLangList[0],cfgChannel,cfgLangList)
    elif cfgLang:
        utils.printSplit("修改Lang.lua的Lang.lang=%s"%cfgLang)
        utils.modifyLangLua(backupFileList, os.path.join(dirPackageSrc, "app", "lang", "Lang.lua"),cfgLang)

    # 开发测试版本
    if cfgTest:
        # 修改developer.lua
        utils.printSplit("修改develop/config.lua")
        utils.modifyDevelopLua(backupFileList, os.path.join(dirPackageSrc, "app", "develop", "config.lua"), 
            cfgTest["guide"], cfgTest["jumpBattle"], cfgTest["fakeReport"], cfgTest["speedBattle"], 
            cfgTest["recharge"], cfgTest["token"], cfgNewVersion["name"], cfgUrl["server"], cfgUrl["gateway"], 
            cfgUrl["config"], cfgTest["gameop"], cfgTest["op"], cfgUrl["rolelist"],cfgUrl["clientserv"]
        )
        # 开发版本切换语言功能
        cfgSwitchLang = cfgTest["switchLang"] if cfgTest.has_key("switchLang") else None
        if cfgSwitchLang:
            utils.modifyDevelopLuaSwitchLang(backupFileList,os.path.join(dirPackageSrc, "app", "develop", "config.lua"),cfgSwitchLang)
        if cfgLangList:
            for lang in cfgLangList:
                utils.printSplit("开发测试版本删除对应语言默认配置")
                utils.removeFile("%s.lua" % os.path.join(dirPackageSrc, "app", "i18n", lang, "url"))
        elif cfgLang:
            utils.printSplit("开发测试版本删除对应语言默认配置")
            utils.removeFile("%s.lua" % os.path.join(dirPackageSrc, "app", "i18n", cfgLang, "url"))

    else:
        # 线上版本删除developer.lua
        utils.printSplit("线上版本删除app/develop")
        utils.removeDir(os.path.join(dirPackageSrc, "app", "develop"))
        # 线上版本不更新不相关语言内容
        if cfgLangList or cfgLang:
            if cfgLangList:
                utils.printSplit("cfgLangList = %s" % str(cfgLangList))
            else:
                utils.printSplit("cfgLang = "+cfgLang)
            dirResI18n = os.path.join(dirPackageRes,"i18n")
            print("dirResI18n = %s"%dirResI18n)
            dirIgnores = ["base"]
            for dirpath, dirnames, filenames in os.walk(dirResI18n):
                for d in dirnames:
                    # print("dirResI18n dir: = %s" % d)
                    fullPath = os.path.join(dirResI18n, d)
                    if os.path.isdir(fullPath) and not d in dirIgnores:
                        if checkNotUsedLang(d,cfgLangList,cfgLang): 
                            print("res 删除不使用语言 " + fullPath)
                            utils.removeDir(fullPath)    
            dirSrcI18n = os.path.join(dirPackageSrc,"app","i18n")
            dirIgnores = ["extends", "utils"]
            print("dirSrcI18n = %s"%dirSrcI18n)
            for dirpath, dirnames, filenames in os.walk(dirSrcI18n):
                for d in dirnames:
                    # print("dirSrcI18n dir: = %s" % d)
                    fullPath = os.path.join(dirSrcI18n, d)
                    if os.path.isdir(fullPath) and not d in dirIgnores:
                        if checkNotUsedLang(d,cfgLangList,cfgLang): 
                            print("src 删除不使用语言 " + fullPath)
                            utils.removeDir(fullPath)    
            dirAudioI18n = dirAudio
            dirIgnores = ["cn"]
            if isAudioPatch:
                dirIgnores = []
            print("dirAudioI18n = %s"%dirAudioI18n)
            for dirpath, dirnames, filenames in os.walk(dirAudioI18n):
                for d in dirnames:
                    # print("dirSrcI18n dir: = %s" % d)
                    fullPath = os.path.join(dirAudioI18n, d)
                    if os.path.isdir(fullPath) and not d in dirIgnores:
                        if checkNotUsedLang(d,cfgLangList,cfgLang): 
                            print("audio 删除不使用语言 " + fullPath)
                            utils.removeDir(fullPath)
            if isAudioPatch:
                for dirpath, dirnames, filenames in os.walk(dirAudioI18n):
                    for filename in filenames:
                        filePath = os.path.abspath(os.path.join(dirpath, filename))
                        hdPath = filePath.replace(os.path.abspath(dirAudioI18n),os.path.abspath(dirAudioHD))
                        if os.path.isfile(filePath):
                            if os.path.exists(hdPath):
                                os.remove(filePath)

            # 删除重复资源 
            if cfgLang != None:
                utils.printSplit("开始删除重复资源")  
                dirResLang = os.path.join(dirResI18n, cfgLang)
                dirResBase = os.path.join(dirResI18n, "base") 
                removeInvalidFile(cfgLang, dirResLang)
                removeInvalidFile(cfgLang, dirResBase)
                utils.printSplit("删除重复资源结束")       

                        

    # args.no32bit = "true"
    utils.printSplit("编译Lua字节码")
    if args.nococos != None and args.nococos.lower() != "false":
        # 编译lua 32
        if args.no32bit == None or args.no32bit.lower() != "true":
            output = utils.luacompileNew(dirPackageSrc, dirPackageSrc32, True, False)
        # 编译lua 64
        output = utils.luacompileNew(dirPackageSrc, dirPackageSrc64, True, True)
    else:
        if args.no32bit == None or args.no32bit.lower() != "true":
            output = utils.luacompile(dirPackageSrc, dirPackageSrc32, True, False)
            print(output)
        # 编译lua 64
        output = utils.luacompile(dirPackageSrc, dirPackageSrc64, True, True)
        print(output)
    utils.removeDir(dirPackageSrc)

    # 打包资源
    utils.printSplit("打包资源")
    isSubpackage = args.subpackage == None or args.subpackage.lower() != "false"
    if isSubpackage:
        output = utils.PackFile(dirPackage, dirProject, True, True, True, "package.assets", "100")
    else:
        output = utils.PackFileUpdate(dirPackage, True, True, True, cfgPackExt)
        pass
    print(output)

    #清理package文件夹
    utils.cleanDir(dirPackage,[])

    utils.printSplit("脚本执行结束")



if __name__ == "__main__":
    utils.runMain(main)
