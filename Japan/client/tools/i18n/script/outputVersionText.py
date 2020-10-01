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

def writeFontToEditorKey(versionJson, lang):
    versionJson["res/fonts/Font_W7.ttf"] = "i18n/%s/fonts/Font_W7.ttf" % (lang)
    versionJson["res/fonts/Font_W8.ttf"] = "i18n/%s/fonts/Font_W8.ttf" % (lang)
    return versionJson

def xlsxToJson(xlsxList,lang="vn"):
    json = {}
    lLoc = 0  # 行号
    kLoc = 1  # key
    vLoc = 3  # value
    for xlsx in list(xlsxList):
        line = xlsx[lLoc]
        if isinstance(line, long):
            # print xlsx[kLoc] + ":" + xlsx[vLoc]
            value = xlsx[vLoc]
            if not value:
                value = ""

            json[xlsx[kLoc]] = value
    writeFontToEditorKey(json, lang)
    return json

def writeJson(json_data, json_file, write_path):
    utils.printSplit("写入json : " + json_file)
    json_path = os.path.join(write_path, json_file)
    utils.writeJsonFile(json_data, json_path)
    utils.printObject(json_data, "JSON WRITE:")
# 生成编辑器文本翻译 editor_key.json
def generateEditorKey(xlsxFile,dirXlsx,dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "editor_key.json"
    sysJsonData = xlsxToJson(sysTextList)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData

# 生成图片字文本翻译 text_key.json
def generateTextKey(xlsxFile,dirXlsx,dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "text_key.json"
    sysJsonData = xlsxToJson(sysTextList)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData

# 生成特效引用文本翻译 effect_key.json
def generateEffectKey(xlsxFile,dirXlsx,dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "effect_key.json"
    sysJsonData = xlsxToJson(sysTextList)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData


def xlsxToLuaTemplate(xlsxList):
    lines = []
    lLoc = 0  # 行号
    kLoc = 1  # key
    vLoc = 3  # value
    
    # utils.printObject(xlsxList, "xlsxList: ")

    lines.append("local language={}\n")
    # lines.append("language[\"" + "123321" + "\"] = " + "\"456879\"" )

    for xlsx in list(xlsxList):
        line = xlsx[lLoc]
        print "xlsx: " + str(xlsx)
        # utils.printObject(xlsx, "xlsx: ")
        print "line: " + str(line)
        print "line type: " + str(type(line))
        print str(xlsx[kLoc]) + ":" +  str(xlsx[vLoc])
        if isinstance(line, long):
            value = xlsx[vLoc]
            if not value:
                value = ""
            # line = "language[\"" + xlsx[kLoc] + "\"] = " + value
            line = "language[" + xlsx[kLoc] + "] = " + value + "\n"
            lines.append( line )

    lines.append("return language")

    return lines


def writeLua(luaLines, luaFile, writePath):
    fullPath = os.path.join(writePath, luaFile)
    utils.writeFile(luaLines, fullPath)
    utils.printObject(luaLines, "Lua WRITE:")

def generateLangTemplate(xlsxFile, dirXlsx, dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    luaFile = "LangTemplate.lua"
    sysLuaList = xlsxToLuaTemplate(sysTextList)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeLua(sysLuaList, luaFile, dirVersion)
    # print sysLuaList


def xlsxToFilterLuaTemplate(xlsxList):
    filterMap = {}
    length = len(xlsxList)
    for idx in range(0, length):
        sheetList = xlsxList[idx]
        for sheet in list(sheetList):
            # 只有一行
            filterStr = str(sheet[0])
            firstStr = filterStr[0:1]
            # print "filterStr: " + filterStr
            # print "filterStr first: " + firstStr
            if not filterMap.has_key(firstStr):
                filterMap[firstStr] = {}
            firstStrIndex = 1
            if filterMap[firstStr].has_key(firstStr):
               firstStrIndex = int(filterMap[firstStr][firstStr]) + 1
            filterMap[firstStr][filterStr] = firstStrIndex

    filter_map = {}

    for first_key, value in filterMap.items():
        filters = []
        for key, index in value.items():
            filters.append(key)
        filter_map[first_key] = filters

    utils.printObject(filter_map, "filter_map: ")

    lines = []
    lines.append("local black_unit={}\n")
    lines.append("local _unit_data={\n")
    # lines.append("[\"" + 123 + "\"] = " + "{ str }" )

    # for xlsx in list(xlsxList):
    #     line = xlsx[lLoc]
    #     print "xlsx: " + str(xlsx)
    #     # utils.printObject(xlsx, "xlsx: ")
    #     print "line: " + str(line)
    #     print "line type: " + str(type(line))
    #     print str(xlsx[kLoc]) + ":" + str(xlsx[vLoc])
    #     if isinstance(line, long):
    #         value = xlsx[vLoc]
    #         if not value:
    #             value = ""
    #         # line = "language[\"" + xlsx[kLoc] + "\"] = " + value
    #         line = "language[" + xlsx[kLoc] + "] = " + value + "\n"
    #         lines.append(line)

    for key, filter_list in filter_map.items():
        filter_str = ""
        for filter in list(filter_list):
            filter_str = filter_str + "\"" + filter + "\","
        lines.append("[\"" + key + "\"] = " + "{" + filter_str + "},\n")
    lines.append("}\n")
    lines.append("              \n")
    lines.append("function black_unit: get(key)\n")
    lines.append("    if _unit_data[key] then\n")
    lines.append("        return _unit_data[key]\n")
    lines.append("    end\n")
    lines.append("        return {}\n")
    lines.append("end\n")
    lines.append("              \n")
    lines.append("return black_unit\n")

    return lines

    # return filter_map



def generateFilterLangTemplate(xlsxFile, dirXlsx, dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    luaFile = "black_units.lua"
    sysLuaList = xlsxToFilterLuaTemplate(sysTextList)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeLua(sysLuaList, luaFile, dirVersion)
    print sysLuaList

def removeInvalidDir(DIR):
    print("cleanDir = %s" % DIR)
    lists = os.walk(DIR)
    print("lists = %s" % lists)
    for root, dirs, files in lists:
        for d in dirs:
            print("dir: = %s" % d)
            names = d.split(".")
            utils.printObject(names,"dirs :")
            path = os.path.join(root, d)
            tmp = utils.getSubDir(DIR, path)
            finded = True
            if names[0] == "" and names[-1] == "Dir":
                finded = False
            if finded:
                removeInvalidDir(path)
                continue
            shutil.rmtree(path)

def main(cfgFile=None):


    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    dirProject          = os.path.join(dirClient, "cocosstudio")


    # tools/config
    dirSysText = os.path.join(dirScript, "..", "sysText")

    # 获取命令行参数
    # optConfig, optPath, _ = utils.getOptions()
    # if optPath != "":
    #     dirClient = optPath

    # cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optConfig)


    # openSysTxtFile = "系统文本2-越南语.xlsx"
    # generateEditorKey(openSysTxtFile, dirSysText, "2018.11.10")

    # openSysTxtFile = "系统文本1-越南语.xlsx"
    # generateLangTemplate(openSysTxtFile, dirSysText, "2018.11.10")

    # openSysTxtFile = "系统文本2-越南语.xlsx"
    # generateEditorKey(openSysTxtFile, dirSysText, "2018.12.04")

    # openSysTxtFile = "系统文本1-越南语.xlsx"
    # generateLangTemplate(openSysTxtFile, dirSysText, "2018.12.04")

    # lang_str = "“樊淼”说：【三国杀名将传】估计一个好玩的（/四星/）*游戏吗？\n但是，我要看《程序大全》。没有时间玩！"
    # pun_str = utils.punctuationChinaToEnglish(lang_str)
    # print pun_str

    openFilterTxtFile = "UI转系统文本.xlsx"
    generateFilterLangTemplate(openFilterTxtFile, dirSysText, "2018.12.20")


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")


if __name__ == "__main__":
    utils.runMain(main)
