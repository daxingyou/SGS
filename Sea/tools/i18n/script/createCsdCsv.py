#!/usr/bin/env python
# coding=utf-8

# from xml.etree import ElementTree as ET
import os
import sys
import json
import platform
import re
import hashlib
import utils
import csd
from csd import ParseCsd as Csd
from csd import UserData as User


def getCsbAllFiles(root_dir):
    ret = []
    ext = ".csd"
    csd_list = utils.getFilesWithExt(root_dir, ext)
    # utils.printObject(csd_list, "csd_list")
    ret = getCsdTexts(csd_list, root_dir)
    return ret


def getCsdTexts(csd_files, root_dir):
    ret = []
    for full_path in csd_files:
        file_dir = full_path.split(os.path.sep)[-2]
        file_name = full_path.split(os.path.sep)[-1]
        # print file_name
        # print file_dir
        # print full_path
        xmlParse = Csd()
        xmlParse.load(full_path)
        textDict = xmlParse.getTextDict()
        # printObject(textDict, full_path)
        csd_root_dir = os.path.join(root_dir,"csui")
        csd_path = full_path[len(str(csd_root_dir))+1:len(str(full_path))]
        if platform.system() == "Windows":
            csd_path = csd_path.replace('\\', '/')
        # print csd_path
        if len(textDict) > 0:
            md = hashlib.md5()
            md.update(open(full_path).read())
            filemd5 = md.hexdigest()
            ret.append({"File": file_name, "TxtList": textDict, "Dir": file_dir, "md5": filemd5,"FullPath": csd_path})
            # ret.append( {"File":file_name,"TxtList":textDict} )
    return ret

# 
# 获取csd文件中的 文本字段
# @csd_list csd文件数据   
# @is_repeat 是否允许生成重复的 editor_key
# @is_editor_key 是否生成 editor_key
# 
def getCsvListWithCsd(csd_list, is_editor_key=False, is_repeat=True):
    ret = []
    _tmp = {}
    _dir = ""
    editor_key = ""
    index = 0
    for csd in csd_list:
        # utils.printObject(csd, "csd:")
        text_list = csd["TxtList"]
        if _dir != csd["Dir"]:
            _dir = csd["Dir"]
            index = 0
        for text_item in text_list:
            key = text_item["name"]
            value = text_item["text"]
            path = text_item["path"]
            if platform.system() == "Windows":
                path = path.replace('\\', '/')
            # for key, value in text.items():
            
            # index = index + 1
            # editor_key = "editor." + _dir + "." + str(index)
            # # ret.append([csd["File"], key, value.encode('utf-8'), editor_key])
            # ret.append([csd["Dir"], csd["File"], key, value.encode('utf-8'), editor_key])

            # csv_head = ["文件夹", "文件名", "控件名", "控件文本", "Key", "控件路径", "md5", "文件路径"]

            if is_repeat == True:  # 允许存在重复数据
                index = index + 1
                editor_key = "editor." + _dir + "." + str(index)
                if is_editor_key == False:
                    editor_key = ""
                # ret.append([csd["File"], key, value.encode('utf-8'), editor_key])
                ret.append([csd["Dir"], csd["File"], key,
                            value.encode('utf-8'), editor_key, path, csd["md5"], csd["FullPath"]])
                            

            if is_repeat == False:  # 去重
                if _tmp.has_key(value):
                    _editor_key_repeat = _tmp[value]
                    # utils.printObject(_tmp, "csd repeat map:")
                    # utils.printObject({key:key,value:value}, "csd repeat data:")
                else:
                    _editor_key_repeat = None

                if _editor_key_repeat != None:
                    if is_editor_key == False:
                        _editor_key_repeat = ""
                    # utils.printObject(_editor_key_repeat, "csd repeat _editor_key_repeat:")
                    ret.append([csd["Dir"], csd["File"], key,
                                value.encode('utf-8'), _editor_key_repeat, path, csd["md5"], csd["FullPath"]])
                else:
                    index = index + 1
                    editor_key = "editor." + _dir + "." + str(index)
                    if is_editor_key == False:
                        editor_key = ""
                    _tmp[value] = editor_key
                    ret.append([csd["Dir"], csd["File"], key,
                                value.encode('utf-8'), editor_key, path, csd["md5"], csd["FullPath"]])

    return ret

# 解析基础的完整数据
def getParseBaseCsvToJson(csv_list):
    # ret = {}
    ret = []
    # for csv_line in csv_list:
    #     _dir = csv_line[0]
    #     _csd = csv_line[1]
    #     _name = csv_line[2]
    #     # _text = csv_line[3]
    #     _text = utils.byteify(csv_line[3])
    #     _text_key = csv_line[4]
    #     _text_path = csv_line[5]
    #     _md5 = csv_line[6]
    #     _path = csv_line[7]
    #     _is_invalid = csv_line[8] == "1"
    #     _is_discarded = csv_line[9] == "3"
    #     # ret.append({"dir":_dir,"csd":_csd,"name": _name, "text":_text,"_text_key":_text_key, "_text_path": _text_path, "md5": _md5, "path":_path, "is_invalid":_is_invalid,"is_discarded":_is_discarded})
    #     ret.append([_dir, _csd,_name,_text,_text_key,_text_path,_md5,_path,_is_invalid,_is_discarded])
    for csv_line in csv_list:
        csv_item = getParseBaseCsvItemToJson(csv_line)
        ret.append(csv_item)
    return ret

# 解析基础的完整数据
def getParseBaseCsvItemToJson(csv_line,is_base=True):
    ret = {}
    _dir = csv_line[0]
    _csd = csv_line[1]
    _name = csv_line[2]
    _text = csv_line[3]
    # _text = utils.byteify(csv_line[3])
    _text_key = csv_line[4]
    _text_path = csv_line[5]
    _md5 = csv_line[6]
    _path = csv_line[7]
    if is_base:
        _is_invalid = csv_line[8] == "1"
        _is_discarded = csv_line[9] == "3"
        ret = {"dir":_dir,"csd":_csd,"name": _name, "text":_text,"text_key":_text_key, "text_path": _text_path, "md5": _md5, "path":_path, "is_invalid":_is_invalid,"is_discarded":_is_discarded}
    else:    
        ret = {"dir":_dir,"csd":_csd,"name": _name, "text":_text,"text_key":_text_key, "text_path": _text_path, "md5": _md5, "path":_path}
    return ret


def _getMathVerionValidCsdTextList(csv_item, base_csv_list):
    is_math = False
    is_invalid = False
    is_change = False
    utils.printObject(csv_item, " ----- csv_item:")
    for base_csv_item in base_csv_list:
        # 7相对路径 2控件名字  3控件内容
        if base_csv_item[7] == csv_item[7] and base_csv_item[2] == csv_item[2] and utils.byteify(base_csv_item[3]) == utils.byteify(csv_item[3]):
            utils.printObject(base_csv_item, " xxxxxxxx base_csv_item:")
            is_math = True
            if base_csv_item[8] == "1" or base_csv_item[9] == "3":
                is_invalid = True
            # 
            if base_csv_item[6] != csv_item[6]:
                is_change = True

    return is_math, is_invalid, is_change

# 获取匹配版本有效内容

def getMathVerionValidCsdTextList(base_csv_list, csv_list, lang_json_data, base_add_list):
    # ret = {}
    valid_list = []
    add_list = []
    chang_map = {} 
    lang_map = {}
    no_math_map = {}
    for csv_item in csv_list:
        csv_data = getParseBaseCsvItemToJson(csv_item,False)
        #匹配之前的数据
        for lang_key, lang_value in lang_json_data.items():

            lang_value_md = hashlib.md5()
            lang_value_md.update(lang_value)
            lang_value_md5 = lang_value_md.hexdigest()
            csv_item_md = hashlib.md5()
            csv_item_md.update(csv_data["text"])
            csv_item_md5 = csv_item_md.hexdigest()

            if lang_value_md5 == csv_item_md5:
                csv_data["text_key"] = lang_key
                csv_item[4] = lang_key

            if not lang_map.has_key("is_init"):
                lang_key_list = lang_key.split(".")  
                lang_key_index = lang_key_list[-1]
                lang_key_name = lang_key_list[-2]
                print "lang_key: " + lang_key
                # print "lang_key_name: " + lang_key_name
                # print "lang_key_index: " + lang_key_index
                if str(lang_key_index) == "ttf":
                    print "continue lang_key: " + lang_key
                    continue
                if not lang_map.has_key(lang_key_name+"_index"):
                    lang_map[lang_key_name+"_index"] = int(lang_key_index)
                if int(lang_map[lang_key_name+"_index"]) < int(lang_key_index):
                    lang_map[lang_key_name+"_index"] = int(lang_key_index)
        
        lang_map["is_init"] = True

        #检测内容是否有效    
        is_math, is_invalid, is_change = _getMathVerionValidCsdTextList(csv_item, base_csv_list)
        # if not lang_map.has_key(csv_data["dir"]):
        #     lang_map[csv_data["dir"]] = []
        # if csv_data["text_key"] == "" and is_invalid == False:
        #     if lang_map.has_key(csv_data["dir"]+"_index"):
        #         index = lang_map[csv_data["dir"]+"_index"]
        #     else:
        #         index = 0 

        #     add_editor_key = "editor." + csv_data["dir"] + "." + str(index+1)

        #     add_value_md = hashlib.md5()
        #     add_value_md.update(csv_data["text"])
        #     add_value_md5 = add_value_md.hexdigest()
        #     if not no_math_map.has_key(add_value_md5):
        #         no_math_map[add_value_md5] = add_editor_key
        #         lang_map[csv_data["dir"]+"_index"] = index+1
        #     else:    
        #         add_editor_key = no_math_map[add_value_md5]

        #     csv_data["text_key"] = add_editor_key
        #     csv_item[4] = add_editor_key
        #     lang_map[csv_data["dir"]].append(csv_data)

        if is_math == True:
            # 匹配有效内容
            if is_invalid == False:
                valid_list.append(csv_data)
            # 匹配但是整个文件有更改  6: md5
            if is_change == True:
                # valid_list.append(csv_item)
                chang_map[csv_data["md5"]] = csv_data
        else: 
            if is_invalid == False:
                add_list.append(csv_data)
                csv_item.append("")
                csv_item.append("")
                base_add_list.append(csv_item)

    utils.printObject(no_math_map, " no_math_map :")
    return valid_list, add_list, chang_map, lang_map


def getAddValidCsdTextList(lang_map, lang_json_data):
    version_map = {}
    add_list = []
    for lang_key, lang_value in lang_json_data.items():
        version_map[lang_key] = lang_value
    # for key, value in lang_map.items():
    #     if isinstance(value, list):
    #         utils.printObject(value, " add " + key + " :")
    #         for csd in value:
    #             add_list.append(csd)
    #             version_map[csd["text_key"]] = csd["text"]

    return version_map, add_list

def getJsonListWithCsd(csd_list):
    ret = {}
    _dir = ""
    editor_key = ""
    index = 0
    for csd in csd_list:
        utils.printObject(csd, "csd:")
        text_list = csd["TxtList"]
        if _dir != csd["Dir"]:
            _dir = csd["Dir"]
            index = 0
        for text in text_list:
            for key, value in text.items():
                # ret.append([csd["Dir"],csd["File"], key, value.encode('utf-8')])
                index = index + 1
                editor_key = "editor." + _dir + "." + str(index)
                ret[editor_key] = value.encode('utf-8')
    return ret


def readJson(json_file, read_path):
    utils.printSplit("读取json: " + json_file)
    json_data, name, jsonPath = utils.readJsonFile(read_path, json_file)
    utils.printObject(json_data, "JSON READ:")
    return json_data, name, jsonPath


def writeJson(json_data, json_file, write_path):
    utils.printSplit("写入json : " + json_file)
    json_path = os.path.join(write_path, json_file)
    utils.writeJsonFile(json_data, json_path)
    utils.printObject(json_data, "JSON WRITE:")


def readCsv(csv_file, read_path):
    utils.printSplit("读取csv :" + csv_file)
    # csv_path = os.path.join(ROOT_PATH, csv_file)
    csv_list, header = utils.readCsvFile(read_path, csv_file)
    # utils.printObject(csv_list, "CVS READ")
    # utils.printObject(len(csv_list), "CVS READ")
    return csv_list, header


def writeCsv(csv_data, csv_file, csv_head, write_path):
    utils.printSplit("写入csv : " + csv_file)
    csv_path = os.path.join(write_path, csv_file)
    if not csv_head:
        # csv_head = ["文件夹","文件名","控件名","控件文本","Key"]
        csv_head = ["文件名", "控件名", "控件文本", "Key"]
    utils.writeCsvFile(csv_data, csv_path, csv_head)
    # utils.printObject(csv_data, "CSV WRITE:")


def readCsd(csd_file, read_path):
    utils.printSplit("读取csd :" + str(csd_file))
    csd_path = os.path.join(read_path, csd_file)
    csdParse = Csd()
    csdParse.load(csd_path)
    return csdParse


def writeCsd(csd_tree, csd_file, write_path):
    utils.printSplit("写入csd :" + csd_file)
    csd_path = os.path.join(write_path, csd_file)
    utils.writeXmlFile(csd_tree, csd_path)

def WriteFontToeditorKey(versionJson,lang):
    if lang == "cn":
        versionJson["res/fonts/Font_W7.ttf"] = "res/fonts/Font_W7.ttf"
        versionJson["res/fonts/Font_W8.ttf"] = "res/fonts/Font_W8.ttf"
    else:
        versionJson["res/fonts/Font_W7.ttf"] = "app/i18n/%s/fonts/Font_W7.ttf" % (lang)
        versionJson["res/fonts/Font_W8.ttf"] = "app/i18n/%s/fonts/Font_W8.ttf" % (lang)
    return versionJson

def main(cfgFile=None):
    # tools/i18n/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # client
    dirClient           = os.path.join(dirScript, os.pardir, os.pardir, os.pardir, "trunk")
    # tools/i18n/csv
    dirCsv          = os.path.join(dirScript, "..", "csv")
    # tools/i18n/json
    dirJson          = os.path.join(dirScript, "..", "json")
    # tools/i18n/base
    dirBase          = os.path.join(dirScript, "..", "base")
    # tools/i18n/config
    dirConfig           = os.path.join(dirScript, "..", "config")
    #
    dirProject = os.path.join(dirClient, "cocosstudio")

    baseLang = "cn"

    print "dirClient 1: " + dirClient


    # 获取命令行参数
    optConfig, optPath, _ = utils.getOptions()
    # if optPath != "":
    #     dirClient = optPath

    print "optPath : " + optPath
    print "dirClient 2: " + dirClient


    # 读取配置
    cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optConfig)
    cfgPackExt          = "assets"
    cfgApp              = cfgFile["app"]
    cfgBuild            = cfgFile["build"]
    cfgLang             = cfgFile["build"]["lang"] if cfgBuild.has_key("lang") else baseLang
    cfgNewVersion       = cfgFile["version"][-1]
    cfgVersionList      = cfgFile["version"]

    # dirOutputJson = os.path.join(dirJson, cfgName)
    # utils.mkOutDir(dirOutputJson, False)

    dirProjectMD5 = os.path.join(dirCsv, cfgName)
    utils.mkOutDir(dirProjectMD5, False)

    base_csv_file = "base.csv"
    base_csv_list, base_header = readCsv(base_csv_file, dirBase)
    base_json_list = getParseBaseCsvToJson(base_csv_list)
    # utils.printObject(base_json_list, " base_json_list:")

    lang_json_file = "lang.json"
    # json_path = os.path.join(ROOT_PATH, json_file)
    lang_json_data, lang_json_name, lang_json_path = readJson(lang_json_file, dirBase)
    utils.printObject(lang_json_data, "JSON Export:")

    csv_head = ["文件夹", "文件名", "控件名", "控件文本", "Key", "控件路径","md5","文件路径"]


    # "res/fonts/Font_W7.ttf":"app/i18n/vn/fonts/Font_W7.ttf",
    # "res/fonts/Font_W8.ttf":"app/i18n/vn/fonts/Font_W8.ttf",

    for version in cfgVersionList:
        dirProject = os.path.join(dirClient, "cocosstudio")
        print "dirProject 1: " + dirProject
        # if version["path"] != "trunk":
        #     dirProject = os.path.join(dirClient, version["path"], "cocosstudio")

        fileVersionCsv = os.path.join(dirProjectMD5, "%s_%s_main.csv" % (version["name"], version["svn"]))
        fileVersionJson = os.path.join(dirProjectMD5, "%s_%s_main.json" % (version["name"], version["svn"]))
        fileVersionLangJson = os.path.join(dirProjectMD5, "%s_%s_lang.json" % (version["name"], version["svn"]))
        fileVersionAddCsv = os.path.join(dirProjectMD5, "%s_%s_add_list.csv" % (version["name"], version["svn"]))
        # fileVersionLangJson = os.path.join(dirOutputJson, "%s_%s_lang.json" % (version["name"], version["svn"]))
        if not os.path.exists(fileVersionCsv):
            # jsonAssets = {}
            #
            # cmd = "svn update --username %s --password %s -r %s %s" % (
            #     svnInfo["n"], svnInfo["p"], version["svn"], dirProject)
            # print(cmd)
            # output = os.popen(cmd).read()

            print "dirProject 2: " + dirProject
            #读取所有CSD文件
            text_list = getCsbAllFiles(dirProject)
            csv_list = getCsvListWithCsd(text_list,False)
            base_add_list = []

            if not os.path.exists(fileVersionJson):
                valid_list, add_list, chang_map, lang_map = getMathVerionValidCsdTextList(base_csv_list,csv_list,lang_json_data,base_add_list)
                versionJson = {"isActive":False,"valid_list": valid_list, "add_list": add_list, "chang_map": chang_map, "lang_map":lang_map}
                # 写入所有有效、新加、和更改过的内容
                writeJson(versionJson, fileVersionJson, dirCsv)
            
            utils.printObject(base_add_list, " base_add_list:")

            #写入版本添加文本到csv
            # if not os.path.exists(fileVersionAddCsv) and len(base_add_list):
            if not os.path.exists(fileVersionAddCsv):
                writeCsv(base_add_list, fileVersionAddCsv, base_header, dirCsv)

            #
            # if not os.path.exists(fileVersionLangJson):
            #    version_map,version_add_list = getAddValidCsdTextList(lang_map,lang_json_data)
            #    versionLangJson = WriteFontToeditorKey(version_map,cfgLang)
            # #    versionLangJson = version_map

            # #    utils.printObject(version_add_list, " version_add_list:")
            #     # 写入版本对应中文 editor文本
            #    writeJson(versionLangJson, fileVersionLangJson, dirCsv)



            #写入版本所有csd中文本 
            writeCsv(csv_list, fileVersionCsv, csv_head, dirCsv)

# from langconv import *
#  # -*- coding：utf-8 -*-
# # 转换繁体到简体
# line = Converter('zh-hans').convert(line.decode('utf-8'))
# line = line.encode('utf-8')
# # 转换简体到繁体
# line = Converter('zh-hant').convert(line.decode('utf-8'))
# line = line.encode('utf-8')


    


if __name__ == "__main__":
    utils.runMain(main)
