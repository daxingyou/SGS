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

def generateEditorKey(xlsxFile,dirXlsx,dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    editorFile = "editor_key.json"
    sysEditorJson = xlsxToJson(sysTextList)
    # editorLangJson = json.dumps(sysEditorJson, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeJson(sysEditorJson, editorFile, dirVersion)
    return sysEditorJson


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
   # utils.printObject(luaLines, "Lua WRITE:")

def generateLangTemplate(xlsxFile, dirXlsx, dirVersion):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    luaFile = "LangTemplate.lua"
    sysLuaList = xlsxToLuaTemplate(sysTextList)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeLua(sysLuaList, luaFile, dirVersion)
    # print sysLuaList

def getBit(lang):
    vLoc = 1
    if lang.lower() == "vn":
        vLoc = 1
    if lang.lower() == "zh":
        vLoc = 1
    if lang.lower() == "tw":
        vLoc = 1   
    if lang.lower() == "kr":
        vLoc = 1
    return vLoc

def xlsxToFilterLuaTemplate(xlsxList,lang="zh"):
    filterMap = {}
    length = len(xlsxList)
    for idx in range(0, length):
        sheetList = xlsxList[idx]
        # print "sheetList: " + str(sheetList)
        for sheet in list(sheetList):
            # print sheet
            if sheet == None:
                continue
            # 只有一行
            #filterStr = str(sheet[0])
            #print type(sheet[0])
            filterStr = sheet[0].decode("utf-8")
            #print "sheet[0] len: " + str(len(filterStr))
            firstStr = filterStr[0:1]
            #print "filterStr: " + filterStr
            #print "filterStr first: " + firstStr
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
    if lang == 'zh':
        utils.printObject(filter_map, "filter_map: ")
    else:
        print json.dumps(filter_map, ensure_ascii=False, indent=4)

    lines = []
    for key, filter_list in filter_map.items():
        filter_str = ""
        for filter in list(filter_list):
            filter_str = filter_str + "\"" + filter + "\","
        lines.append("[\"" + key + "\"] = " + "{" + filter_str + "},\n")
    template = '''local black_unit={}
local _unit_data={
%s
}
function black_unit:get(key)
    if _unit_data[key] then
        return _unit_data[key]
    end
    return {}
end

return black_unit 
''' 
    result = []
    result.append(template % "".join(lines))
    return result

    # return filter_map



def generateFilterLangTemplate(xlsxFile, dirXlsx, dirVersion,lang="zh"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    luaFile = "black_units.lua"
    # print sysTextList
    sysLuaList = xlsxToFilterLuaTemplate(sysTextList,lang)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeLua(sysLuaList, luaFile, dirVersion)
    # print sysLuaList

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

    targetLang = "vn"

    # openFilterTxtFile = "过滤单词-越南语.xlsx"
    # generateFilterLangTemplate(openFilterTxtFile, dirSysText, "2018.12.20",targetLang.lower())

    # openFilterTxtFile = "过滤单词-韩国.xlsx"
    # generateFilterLangTemplate(openFilterTxtFile, dirSysText, "kr_filter_20190727",targetLang.lower())

    targetLang = "tw"
    openFilterTxtFile = "tw_filter.xlsx"
    generateFilterLangTemplate(openFilterTxtFile, dirSysText, "tw_filter_20190729",targetLang.lower())

    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")


if __name__ == "__main__":
    utils.runMain(main)
