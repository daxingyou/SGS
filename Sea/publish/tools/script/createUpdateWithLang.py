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

def getLangList(path):
    langList = []
    print("getLangList path = %s" % path)
    lists = os.walk(path)
    for root, dirs, files in lists:
        for d in dirs:
            dirPath = os.path.join(path, d)
            if os.path.exists(dirPath) and d != "cn" and d != "base":
                langList.append( str(d) )
    return langList

def getMathLangList(matchStr):
    matchLangList =  matchStr.split("|")
    print("getMathLangList str = %s" % matchStr)
    return matchLangList

def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-p", "--project", dest="project")
    parser.add_argument("-ncc", "--nococos", dest="nococos")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "vermd5")

    # 读取配置
    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)

    cfgPackExt          = "assets"
    cfgUrl              = cfgFileVersion["url"]
    cfgTest             = cfgFileVersion["test"] if cfgFileVersion.has_key("test") else None
    cfgNewVersion       = cfgFileVersion["version"][-1]
    cfgVersionList      = cfgFileVersion["version"]

    # 国际化配置
    cfgI18n             = cfgFileVersion["i18n"] if cfgFileVersion.has_key("i18n") else {} 
    cfgLang             = cfgI18n["lang"] if cfgI18n.has_key("lang") else None 
    cfgMatchLang        = cfgI18n["matchLang"] if cfgI18n.has_key("matchLang") else None

    if cfgNewVersion["path"] == "trunk":
        dirProjectCCS = os.path.join(args.project, "cocosstudio")
    else:
        dirProjectCCS = os.path.join(args.project, cfgNewVersion["path"], "cocosstudio")
    #
    dirOutput           = os.path.join(dirScript, "..", "..", "i18n_update", cfgNewVersion["name"])
    dirTemp             = os.path.join(dirOutput, "versions")
    dirProject          = os.path.join(dirOutput, "project")
    dirZip              = os.path.join(dirOutput, "zip")
    dirProjectMD5       = os.path.join(dirMD5, args.config)

    # 清理文件夹
    utils.printSplit("清理文件夹")
    # print("Path: %s" % dirOutput)
    utils.mkOutDir(dirOutput, 1)
    utils.printSplit("清理文件夹")

    # 更新svn
    # utils.printSplit("更新svn")
    # cmd = "svn revert --depth infinity %s" % (dirProjectCCS)
    # print(cmd)
    # output = os.popen(cmd).read()
    # print(output)

    # svnInfo = utils.getSVNInfo()
    # cmd = "svn update --accept theirs-full --username %s --password %s -r %s %s" % (svnInfo["n"], svnInfo["p"], cfgNewVersion["svn"], dirProjectCCS)
    # print(cmd)
    # output = os.popen(cmd).read()
    # print(output)

    # cmd = "svn status %s" % (dirProjectCCS)
    # print(cmd)
    # output = os.popen(cmd).read()
    # print(output)

    ##### 处理多语言列表 ################################################################################################  
    utils.printSplit("制作在线更新语言")

    langMatchList = []
    cfgLangList = []
    dirLangList = []
    if cfgMatchLang :
        cfgLangList = getMathLangList(cfgMatchLang)
        print("cfgLangList", cfgLangList)
        if len(cfgLangList):
            langMatchList = cfgLangList
    else:
        dirLangList = getLangList(os.path.join(dirProjectCCS, "res", "i18n"))
        print("dirLangList", dirLangList)
        if len(dirLangList):
            langMatchList = dirLangList
        pass

    if not cfgLang in langMatchList:
        langMatchList.append(cfgLang)
    print("langMatchList", langMatchList)

    # return 
    ##### 处理最新版本代码和资源 ################################################################################################  
    # 拷贝资源到xgame/package
    utils.printSplit("拷贝lua")
    utils.copyDir(os.path.join(dirProjectCCS, "src"), os.path.join(dirProject, "src", "temp"))
    utils.printSplit("拷贝lua")
    
    # 修改config.lua
    backupFileList = list()
    utils.printSplit("修改config.lua")
    utils.modifyConfigLua(backupFileList, os.path.join(dirProject, "src", "temp", "config.lua"), 
        cfgNewVersion["name"], cfgUrl["server"], cfgUrl["gateway"], cfgUrl["config"], cfgUrl["rolelist"]
    )
    utils.printSplit("修改config.lua")

    # 修改Lang.lua
    if cfgLang:
        utils.printSplit("修改Lang.lua的Lang.lang=%s"%cfgLang)
        utils.modifyLangLua(backupFileList, os.path.join(dirProject, "src", "temp", "app", "lang", "Lang.lua"),cfgLang)

    # 备份developer.lua
    #utils.backUpFile(backupFileList, os.path.join(dirProject, "src/developer.lua"))
    #utils.removeFile(os.path.join(dirProject, "src/developer.lua"))
    utils.backUpFile(backupFileList, os.path.join(dirProject, "src", "temp", "main.lua"))
    utils.removeFile(os.path.join(dirProject, "src", "temp", "main.lua"))
    if cfgTest:
        # 修改developer.lua
        utils.printSplit("修改develop/config.lua")
        utils.modifyDevelopLua(backupFileList, os.path.join(dirProject, "src", "temp", "app", "develop", "config.lua"), 
            cfgTest["guide"], cfgTest["jumpBattle"], cfgTest["fakeReport"], cfgTest["speedBattle"], 
            cfgTest["recharge"], cfgTest["token"], cfgNewVersion["name"], cfgUrl["server"], cfgUrl["gateway"],
            cfgUrl["config"], cfgTest["gameop"], cfgTest["op"], cfgUrl["rolelist"]
        )
    else:
        # 线上版本删除developer.lua
        utils.printSplit("线上版本删除app/develop")
        utils.removeDir(os.path.join(dirProject, "src", "temp", "app", "develop"))
        if cfgLang:
            # 热更新不更新不相关语言内容
            utils.printSplit("cfgLang = "+cfgLang)
            dirResI18n = os.path.join(dirProject, "i18n")
            print("dirResI18n = %s"%dirResI18n)
            dirIgnores = ["base"]
            for dirpath, dirnames, filenames in os.walk(dirResI18n):
                for d in dirnames:
                    # print("dirResI18n dir: = %s" % d)
                    fullPath = os.path.join(dirResI18n, d)
                    if os.path.isdir(fullPath) and not d in dirIgnores:
                        if cfgLang != d: 
                            print("res 删除不使用语言 " + fullPath)
                            utils.removeDir(fullPath)    
            dirSrcI18n = os.path.join(dirProject,"app","i18n")
            dirIgnores = ["extends", "utils"]
            print("dirSrcI18n = %s"%dirSrcI18n)
            for dirpath, dirnames, filenames in os.walk(dirSrcI18n):
                for d in dirnames:
                    # print("dirSrcI18n dir: = %s" % d)
                    fullPath = os.path.join(dirSrcI18n, d)
                    if os.path.isdir(fullPath) and not d in dirIgnores:
                        if cfgLang != d: 
                            print("src 删除不使用语言 " + fullPath)
                            utils.removeDir(fullPath)    

    # lua compile
    utils.printSplit("编译Lua32字节码")
    if args.nococos != None and args.nococos.lower() != "false":
        output = utils.luacompileNew(os.path.join(dirProject, "src", "temp"), os.path.join(dirProject, "src", "bit32"), True, False)
        utils.printSplit("编译Lua64字节码")
        output = utils.luacompileNew(os.path.join(dirProject, "src", "temp"), os.path.join(dirProject, "src", "bit64"), True, True)
    else:
        output = utils.luacompile(os.path.join(dirProject, "src", "temp"), os.path.join(dirProject, "src", "bit32"), True, False)
        print(output)
        utils.printSplit("编译Lua32字节码")
        utils.printSplit("编译Lua64字节码")
        output = utils.luacompile(os.path.join(dirProject, "src", "temp"), os.path.join(dirProject, "src", "bit64"), True, True)
        print(output)
        utils.printSplit("编译Lua64字节码")
    
    utils.removeDir(os.path.join(dirProject, "src", "temp"))

    #
    utils.printSplit("拷贝res")
    utils.copyDir(os.path.join(dirProjectCCS, "res"), os.path.join(dirProject, "res"))
    utils.printSplit("拷贝res")
    
    # packfile
    utils.printSplit("压缩加密")
    output = utils.PackFile(dirProject, False, True, True, cfgPackExt)
    print(output)
    utils.printSplit("压缩加密")

    #
    utils.printSplit("拷贝audio")
    utils.copyDir(os.path.join(dirProjectCCS, "audio"), os.path.join(dirProject, "audio"))
    utils.printSplit("拷贝audio")
    ##### 处理最新版本代码和资源 ################################################################################################


    ##### 统计版本号 ##########################################################################################################
    utils.printSplit("统计版本号")
    versionSearch = []
    # 统计大版本号
    for version in cfgVersionList:
        if not version["path"] in versionSearch:
            versionSearch.append(version["path"])

    # 保留第一个版本和最新3个版本
    if len(versionSearch) > 4:
        del versionSearch[1:-3]
    # 删除最新大版本号
    del versionSearch[-1]
    print("versionSearch", versionSearch)

    # 统计最终打包版本
    versionGroup = {}
    for key in versionSearch:
        versionGroup[key] = []

    for version in cfgVersionList:
        # if version["path"] == cfgNewVersion["path"] or version["path"] == versionSearch[-1]:
        if version["path"] == cfgNewVersion["path"]:
            versionGroup[version["name"]] = [version]
        else:
            if versionGroup.has_key(version["path"]):
                versionGroup[version["path"]].append(version)
            else:
                versionGroup[versionSearch[0]].append(version)

    print("versionGroup", versionGroup)
    utils.printSplit("统计版本号")
    ##### 统计版本号 ##########################################################################################################

    ##### 根据语言 对比版本，拷贝文件 ###################################################################################################
    utils.mkOutDir(dirZip, True)
    # 处理底包版本
    firstVersion = cfgVersionList[0]
    if len(versionSearch) > 1:
        firstVersion = versionSearch[0]
    print("firstVersion:", firstVersion)

    for lang in langMatchList:
        dirProjectSubs = ["res", "src", "audio"]
        lastVersionInfo = None
        for version in cfgVersionList:
            
            # 跳过忽略版本
            if version.has_key("ignore") and (version["ignore"] == "true" or version["ignore"] == True):
                print("忽略version:",version)
                continue

            dirTempVersion = os.path.join(dirTemp, lang, version["name"])
            dirTempVersionZip = os.path.join(dirTempVersion, "zip")
            dirTempVersionSrc32 = os.path.join(dirTempVersionZip, "src", "bit32")
            dirTempVersionSrc64 = os.path.join(dirTempVersionZip, "src", "bit64")

            diffFiles = {}
            utils.printSplit("%s:%s" % (version["name"], version["svn"]))
            if version["name"] != cfgNewVersion["name"]:
    
                # 比较版本
                print("比较版本")
                diffFiles = utils.getDiffFilesWithLang(os.path.join(dirProjectMD5, "%s_%s.md5" %(version["name"], version["svn"])),
                        os.path.join(dirProjectMD5, "%s_%s.md5" %(cfgNewVersion["name"], cfgNewVersion["svn"])),lang)
                diffFiles["src"].append("config.lua")
                print(diffFiles)

                # # 根据对比内容拷贝文件到版本目录
                # print("拷贝文件")
                # for sub in dirProjectSubs:
                #     dirProjectSub = os.path.join(dirProject, sub)
                #     files = diffFiles[sub]
                #     if sub == "audio":
                #         utils.copyDiffFiles(files, dirProjectSub, os.path.join(dirTempVersion, "audio"))
                #     elif sub == "src":
                #         utils.copyDiffFiles(files, os.path.join(dirProjectSub, "bit32"), dirTempVersionSrc32)
                #         utils.copyDiffFiles(files, os.path.join(dirProjectSub, "bit64"), dirTempVersionSrc64)
                #     else:
                #         utils.copyDiffFiles(files, dirProjectSub, os.path.join(dirTempVersionZip, sub))

                # # 写入最新版本versioncode
                # versioncode = str(utils.versionNumber(cfgNewVersion["name"]))
                # print("versioncode",versioncode)
                # f = open(os.path.join(dirTempVersion, "code"), 'wb')
                # f.write(versioncode)
                # f.close()

                # utils.printSplit("%s:%s" % (version["name"], version["svn"]))
            if version["name"] == cfgNewVersion["name"]:
                # 获取当前语言完整版本内容
                print("获取%s在%s的完整内容" % (lang, cfgNewVersion["name"]))
                diffFiles = utils.geLangFiles(os.path.join(dirProjectMD5, "%s_%s.md5" %(cfgNewVersion["name"], cfgNewVersion["svn"])),lang)

            diffFiles["src"].append("config.lua")   
            print(diffFiles)
            # 根据对比内容拷贝文件到版本目录
            print("拷贝文件")
            for sub in dirProjectSubs:
                dirProjectSub = os.path.join(dirProject, sub)
                files = diffFiles[sub]
                if sub == "audio":
                    utils.copyDiffFiles(files, dirProjectSub, os.path.join(dirTempVersion, "audio"))
                elif sub == "src":
                    utils.copyDiffFiles(files, os.path.join(dirProjectSub, "bit32"), dirTempVersionSrc32)
                    utils.copyDiffFiles(files, os.path.join(dirProjectSub, "bit64"), dirTempVersionSrc64)
                else:
                    utils.copyDiffFiles(files, dirProjectSub, os.path.join(dirTempVersionZip, sub))

            # 写入最新版本versioncode
            versioncode = str(utils.versionNumber(cfgNewVersion["name"]))
            print("versioncode",versioncode)
            f = open(os.path.join(dirTempVersion, "code"), 'wb')
            f.write(versioncode)
            f.close()
            utils.printSplit("%s:%s" % (version["name"], version["svn"]))    
        ##### 对比版本，拷贝文件 ###################################################################################################

        ##### 生成版本文件 ########################################################################################################
        jsonConfig = {}
        jsonAssets = {}
        jsonConfig["version"] = cfgNewVersion["name"]
        jsonConfig["assets"] = jsonAssets
        utils.mkOutDir(os.path.join(dirZip, lang), True)
        for group in versionGroup:
            utils.printSplit("%s:%s" % (group, cfgNewVersion["name"]))
            # 
            print("拷贝子版本到大版本目录")
            pathname = os.path.join(dirZip, lang, group)
            for version in versionGroup[group]:
                print(os.path.join(dirTemp, lang, version["name"]), pathname)
                utils.copyDir2(os.path.join(dirTemp, lang, version["name"]), pathname)
                      
            #单个版本小更新 最低版本包为完整包 
            if len(versionSearch) == 0 and group == firstVersion["name"] : 
                utils.copyDir2(os.path.join(dirTemp, lang, cfgNewVersion["name"]), pathname)

            #跨版本 最低版本包为完整包 
            if len(versionSearch) > 0 and group == firstVersion["path"] : 
                utils.copyDir2(os.path.join(dirTemp, lang, cfgNewVersion["name"]), pathname)

            #
            print("添加文件到zip")
            zipFile = None
            zipFileName = "%s_%s_%s.sha" % (lang,group, cfgNewVersion["name"])
            # 完整的语言版本
            if group == cfgNewVersion["name"]:
                # 单个版本小更新
                if len(versionSearch) == 0 : 
                    zipFileName = "%s_%s_%s.sha" % (lang, firstVersion["name"], cfgNewVersion["name"])
                    pathname = os.path.join(dirZip, lang, firstVersion["name"])
                # 跨版本
                else: 
                    zipFileName = "%s_%s_%s.sha" % (lang, firstVersion["path"], cfgNewVersion["name"])
                    pathname = os.path.join(dirZip, lang, firstVersion["path"])
                
                utils.removeDir(os.path.join(dirZip, lang, cfgNewVersion["name"]))
                zipFilePath = os.path.join(dirOutput, zipFileName)
                if not zipFile:
                    zipFile = zipfile.ZipFile(zipFilePath, "a")
            else:
                zipFilePath = os.path.join(dirOutput, zipFileName)
                print(zipFilePath)
                for dirpath, dirnames, filenames in os.walk(pathname):
                    sub = dirpath[len(pathname):].strip("/\\")
                    for filename in filenames:
                        base, ext = os.path.splitext(filename)
                        if ext == ".lua":
                            continue
                        if not zipFile:
                            zipFile = zipfile.ZipFile(zipFilePath, "a")
                        zipFile.write(
                            os.path.join(dirpath, filename),
                            os.path.join(sub, filename), zipfile.ZIP_DEFLATED)

        
            #
            print("生成zip文件")
            if zipFile:
                utils.printObject(zipFile.namelist(), zipFileName)
                zipFile.close()

                info = {}
                info["size"] = os.path.getsize(zipFilePath)
                info["file"] = zipFileName

                idx_cdn = 0
                cfgCDNList = cfgUrl["cdn_list"]
                if cfgUrl.has_key("i18n_cdn_list"):
                    cfgCDNList = cfgUrl["i18n_cdn_list"]
                for cdn in cfgCDNList:
                    cdn_path = "path"
                    if idx_cdn > 0:
                        cdn_path = "path%d" % idx_cdn

                    info[cdn_path] = "%s/%s/%s" % (cdn, cfgNewVersion["name"], zipFileName)
                    idx_cdn = idx_cdn + 1

                md = hashlib.md5()
                md.update(open(zipFilePath).read())
                info["md5"] = md.hexdigest()

                for version in versionGroup[group]:
                    jsonAssets[version["name"]] = info
            utils.printSplit("%s:%s" % (group, cfgNewVersion["name"]))
                
        ##### 生成版本文件 ########################################################################################################

        utils.printObject(jsonConfig, "jsonConfig")
        utils.printSplit("创建config文件")
        # http
        for assetInfo in jsonAssets:
            path = jsonAssets[assetInfo]["path"]
            jsonAssets[assetInfo]["path"] = path.replace("https:", "http:")
        # 
        configPath = os.path.join(dirOutput, "%s_%s" % (lang,"config_http"))
        json.dump(jsonConfig, open(configPath, "w"),indent=4)
        # utils.printObject(jsonConfig, "%s_%s" % (lang,"config_http")
        utils.printSplit("http预加载url地址")
        if cfgUrl.has_key("i18n_cdn_list"):
            print("%s/%s/%s_config_http" % (cfgUrl["i18n_cdn_list"][0].replace("https:", "http:"), cfgNewVersion["name"],lang))
        else:
            print("%s/%s/%s_config_http" % (cfgUrl["cdn_list"][0].replace("https:", "http:"), cfgNewVersion["name"],lang))
        pathPrint = []
        for assetInfo in jsonAssets:
            path = jsonAssets[assetInfo]["path"]
            if not path in pathPrint:
                pathPrint.append(path)
                print(path)

        # https
        for assetInfo in jsonAssets:
            path = jsonAssets[assetInfo]["path"]
            jsonAssets[assetInfo]["path"] = path.replace("http:", "https:")
        # 
        configPath = os.path.join(dirOutput, "%s_%s" % (lang,"config_https"))
        json.dump(jsonConfig, open(configPath, "w"),indent=4)
        # utils.printObject(jsonConfig, "%s_%s" % (lang,"config_https"))
        utils.printSplit("https预加载url地址")
        if cfgUrl.has_key("i18n_cdn_list"):
            print("%s/%s/%s_config_https" % (cfgUrl["i18n_cdn_list"][0].replace("http:", "https:"), cfgNewVersion["name"],lang))
        else:
            print("%s/%s/%s_config_https" % (cfgUrl["cdn_list"][0].replace("http:", "https:"), cfgNewVersion["name"],lang))
        pathPrint = []
        for assetInfo in jsonAssets:
            path = jsonAssets[assetInfo]["path"]
            if not path in pathPrint:
                pathPrint.append(path)
                print(path)

        #utils.printObject(jsonConfig, "config.json")
        # utils.restoreFile(backupFileList)

        # utils.removeDir(dirTemp)
        # utils.removeDir(dirProject)
        # utils.removeDir(dirZip)
    

    utils.printSplit("脚本执行结束")
    
if __name__ == "__main__":
    utils.runMain(main)
