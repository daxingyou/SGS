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
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    dirProject          = os.path.join(dirClient, "cocosstudio")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    # cocosstudio/res
    dirPackageRes       = os.path.join(dirProject, "res")

    # 获取命令行参数
    optConfig, optPath, _  = utils.getOptions()
    if optPath != "":
        dirClient = optPath

    # 读取配置
    cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optConfig)
    cfgPackExt          = "assets"
    cfgApp              = cfgFile["app"]
    cfgUrl              = cfgFile["url"]
    cfgBuild            = cfgFile["build"]
    cfgTest             = cfgFile["test"] if cfgFile.has_key("test") else None
    cfgNewVersion       = cfgFile["version"][-1]
    cfgVersionList      = cfgFile["version"]
    cfgLang             = cfgBuild["lang"] if cfgBuild.has_key("lang") else "vn"


    if cfgNewVersion["path"] == "trunk":
        dirProject = os.path.join(dirClient, "cocosstudio")
    else:
        dirProject = os.path.join(dirClient, cfgNewVersion["path"], "cocosstudio")
    #
    dirOutput           = os.path.join(dirScript, "..", "..", "update", cfgNewVersion["name"])
    dirTemp             = os.path.join(dirOutput, "versions")
    dirProjectMD5       = os.path.join(dirMD5, cfgName)

    # 清理文件夹
    utils.printSplit("清理文件夹")
    print("Path: %s" % dirOutput)
    utils.mkOutDir(dirOutput, 1)

    # 更新svn
    utils.printSplit("更新svn")
    cmd = "svn revert --depth infinity %s" % (dirProject)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    svnInfo = utils.getSVNInfo()
    cmd = "svn update --accept theirs-full --username %s --password %s -r %s %s" % (svnInfo["n"], svnInfo["p"], cfgNewVersion["svn"], dirProject)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    cmd = "svn status %s" % (dirProject)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    # 修改config.lua
    backupFileList = list()
    utils.printSplit("修改config.lua")
    utils.modifyConfigLua(backupFileList, os.path.join(dirProject, "src", "config.lua"), 
        cfgNewVersion["name"], cfgUrl["server"], cfgUrl["gateway"], cfgUrl["config"], cfgUrl["rolelist"]
    )

    # 修改Lang.lua
    if cfgLang:
        utils.printSplit("修改Lang.lua的Lang.lang=%s"%cfgLang)
        utils.modifyLangLua(backupFileList, os.path.join(dirProject, "src", "app", "lang", "Lang.lua"),cfgLang)

    # 备份developer.lua
    #utils.backUpFile(backupFileList, os.path.join(dirProject, "src/developer.lua"))
    #utils.removeFile(os.path.join(dirProject, "src/developer.lua"))
    utils.backUpFile(backupFileList, os.path.join(dirProject, "src", "main.lua"))
    utils.removeFile(os.path.join(dirProject, "src", "main.lua"))
    if cfgTest:
        # 修改developer.lua
        utils.printSplit("修改develop/config.lua")
        utils.modifyDevelopLua(backupFileList, os.path.join(dirProject, "src", "app", "develop", "config.lua"), 
            cfgTest["guide"], cfgTest["jumpBattle"], cfgTest["fakeReport"], cfgTest["speedBattle"], 
            cfgTest["recharge"], cfgTest["token"], cfgNewVersion["name"], cfgUrl["server"], cfgUrl["gateway"], cfgUrl["config"], cfgTest["gameop"], cfgTest["op"], cfgUrl["rolelist"]
        )
    else:
        # 线上版本删除developer.lua
        utils.printSplit("线上版本删除app/develop")
        utils.removeDir(os.path.join(dirProject, "src", "app", "develop"))
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

    #
    jsonConfig = {}
    jsonAssets = {}
    jsonConfig["version"] = cfgNewVersion["name"]
    jsonConfig["assets"] = jsonAssets
    dirProjectSubs = ["res", "src", "audio"]
    lastVersionInfo = None
    for version in cfgVersionList:
        if version["name"] != cfgNewVersion["name"]:
            utils.printSplit("%s:%s" % (version["name"], version["svn"]))

            if version.has_key("ignore") and version["ignore"] == "true":
                if lastVersionInfo != None:
                    info = {}
                    for infoKey in lastVersionInfo:
                        info[infoKey] = lastVersionInfo[infoKey]
                    jsonAssets[version["name"]] = info
            else:
                dirTempVersion = os.path.join(dirTemp, version["name"])
                dirTempVersionZip = os.path.join(dirTempVersion, "zip")
                dirTempVersionSrc = os.path.join(dirTempVersionZip, "src", "temp")
                dirTempVersionSrc32 = os.path.join(dirTempVersionZip, "src", "bit32")
                dirTempVersionSrc64 = os.path.join(dirTempVersionZip, "src", "bit64")


                # diffFiles = utils.getDiffFiles(os.path.join(dirProjectMD5, "%s_%s.md5" %(version["name"], version["svn"])),
                #         os.path.join(dirProjectMD5, "%s_%s.md5" %(cfgNewVersion["name"], cfgNewVersion["svn"])))
                diffFiles = utils.getDiffFilesMatchLang(os.path.join(dirProjectMD5, "%s_%s.md5" %(version["name"], version["svn"])),
                        os.path.join(dirProjectMD5, "%s_%s.md5" %(cfgNewVersion["name"], cfgNewVersion["svn"])),cfgLang)

                # diff
                utils.printSplit("比较版本")
                for sub in dirProjectSubs:
                    dirProjectSub = os.path.join(dirProject, sub)
                    files = diffFiles[sub]
                    if sub == "src":
                        files.append("config.lua")
                    if sub == "audio":
                        utils.copyDiffFiles(files, dirProjectSub, os.path.join(dirTempVersion, "audio"))
                    elif sub == "src":
                        utils.copyDiffFiles(files, dirProjectSub, dirTempVersionSrc)
                    else:
                        utils.copyDiffFiles(files, dirProjectSub, os.path.join(dirTempVersionZip, sub))

                #
                f = open(os.path.join(dirTempVersion, "code"), 'wb')
                f.write(str(utils.versionNumber(cfgNewVersion["name"])))
                f.close()

                # lua compile
                utils.printSplit("编译Lua32字节码")
                output = utils.luacompile(dirTempVersionSrc, dirTempVersionSrc32, 
                    cfgBuild["lua"]["compile"], 
                    False,
                    cfgBuild["lua"]["encrypt"], 
                    utils.getuuid(cfgBuild["lua"]["key"]), 
                    utils.getuuid(cfgBuild["lua"]["sign"])
                )
                print(output)

                utils.printSplit("编译Lua64字节码")
                output = utils.luacompile(dirTempVersionSrc, dirTempVersionSrc64, 
                    cfgBuild["lua"]["compile"], 
                    True,
                    cfgBuild["lua"]["encrypt"], 
                    utils.getuuid(cfgBuild["lua"]["key"]), 
                    utils.getuuid(cfgBuild["lua"]["sign"])
                )
                print(output)
                utils.removeDir(dirTempVersionSrc)

                # packfile
                utils.printSplit("压缩加密")
                output = utils.PackFile(dirTempVersionZip, False, cfgBuild["package"]["compress"], 
                    cfgBuild["package"]["encrypt"], utils.getuuid(cfgBuild["package"]["key"]), cfgPackExt
                )
                print(output)

                # pack
                utils.printSplit("生成zip文件")
                zipFile = None
                zipFileName = "%s_%s.sha" % (version["name"], cfgNewVersion["name"])
                zipFilePath = os.path.join(dirOutput, zipFileName)
                print(zipFilePath)
                for dirpath, dirnames, filenames in os.walk(dirTempVersion):
                    sub = dirpath[len(dirTempVersion):].strip("/\\")
                    for filename in filenames:
                        base, ext = os.path.splitext(filename)
                        if ext == ".lua":
                            continue
                        if not zipFile:
                            zipFile = zipfile.ZipFile(zipFilePath, "a")
                        zipFile.write(
                            os.path.join(dirpath, filename),
                            os.path.join(sub, filename), zipfile.ZIP_DEFLATED)

                if zipFile:
                    utils.printObject(zipFile.namelist(), zipFileName)
                    zipFile.close()
                    md = hashlib.md5()
                    md.update(open(zipFilePath).read())
                    info = {}
                    info["size"] = os.path.getsize(zipFilePath)
                    info["file"] = zipFileName

                    idx_cdn = 0
                    cfgCDNList = cfgUrl["cdn_list"]
                    for cdn in cfgCDNList:
                        cdn_path = "path"
                        if idx_cdn > 0:
                            cdn_path = "path%d" % idx_cdn

                        #if cfgTest:
                        #    info[cdn_path] = "%s/%s" % (cdn, zipFileName)
                        #else:
                        info[cdn_path] = "%s/%s/%s" % (cdn, cfgNewVersion["name"], zipFileName)

                        idx_cdn = idx_cdn + 1

                    info["md5"] = md.hexdigest()
                    jsonAssets[version["name"]] = info
                    lastVersionInfo = info


            utils.printSplit("%s:%s" % (version["name"], version["svn"]))

    
    utils.printSplit("创建config文件")

    # write max version
    configPath = os.path.join(dirOutput, "config")
    json.dump(jsonConfig, open(configPath, "w"),indent=4)
    #open(configPath, "w").write(jsonConfig)

    utils.printObject(jsonConfig, "config.json")
    utils.restoreFile(backupFileList)

    utils.removeDir(dirTemp)

    utils.printSplit("预加载url地址")
    for assetInfo in jsonAssets:
        print(jsonAssets[assetInfo]["path"])
    
    print("%s/%s/config" % (cfgUrl["cdn_list"][0], cfgNewVersion["name"]))

    utils.printSplit("脚本执行结束")
    
if __name__ == "__main__":
    utils.runMain(main)
