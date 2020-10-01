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

def setCsdNodeString(csd_file, node_name, txt, node_path):
    if csd_file and node_name:
        csd_file.setNodeText(node_name, txt, node_path)

def parseVersionCsvKeyResetToCsd(csv_list,version_csd_path):
    csd_root_dir = os.path.join(version_csd_path, "csui")
    for csv_line in csv_list:
        _dir = csv_line[0]
        _csd = csv_line[1]
        _name = csv_line[2]
        _text = csv_line[3]
        # _text = utils.byteify(csv_line[3])
        _text_key = csv_line[4]
        _text_path = csv_line[5]
        _md5 = csv_line[6]
        _path = csv_line[7]

        utils.printObject(_dir, "csv _dir:")
        utils.printObject(_csd, "csv csd:")
        utils.printObject(_name, "csv name:")
        full_path = os.path.join(csd_root_dir, _path)
        if _name != None and _name != "" and full_path != None:
            utils.printObject(full_path, "csv csd full_path:")
            csdParse = Csd()
            csdParse.load(full_path)
            print(_csd + "  node" + _name + "  last: " + csdParse.getNodeText(_name, _text_path))
            setCsdNodeString(csdParse, _name, _text_key, _text_path)
            print(_csd + "  node" + _name + "  now: " + csdParse.getNodeText(_name, _text_path))
            csdParse.save()
    pass


# 解析基础的完整数据
def parseBaseCsvItemToJson(csv_line,is_base=True):
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


def mathVersionCsd(csv_item, version_csv_list):
    for version_csv_item in version_csv_list:
        # 7相对路径 2控件名字  3控件内容
        if version_csv_item[7] == csv_item[7] and version_csv_item[2] == csv_item[2] and utils.byteify(version_csv_item[3]) == utils.byteify(csv_item[3]):
            return version_csv_item
    return None

# 获取匹配版本有效内容
def parseVerionAddCsdWithCsv(version_csv_list, lang_json_data, version_add_list):
    add_map = {}
    lang_map = {}
    no_math_map = {}

    for csv_item in version_add_list:
        csv_data = parseBaseCsvItemToJson(csv_item, True)
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
                if not lang_map.has_key(lang_key_name+"_index"):
                    lang_map[lang_key_name+"_index"] = int(lang_key_index)
                if int(lang_map[lang_key_name+"_index"]) < int(lang_key_index):
                    lang_map[lang_key_name+"_index"] = int(lang_key_index)

        lang_map["is_init"] = True

        #检测内容是否有效

        version_csv_item = mathVersionCsd(csv_item, version_csv_list)
        if version_csv_item:
            if csv_data["text_key"] == "" and csv_data["is_invalid"] == False:
                if lang_map.has_key(csv_data["dir"]+"_index"):
                    index = lang_map[csv_data["dir"]+"_index"]
                else:
                    index = 0

                add_editor_key = "editor." + csv_data["dir"] + "." + str(index+1)

                add_value_md = hashlib.md5()
                add_value_md.update(csv_data["text"])
                add_value_md5 = add_value_md.hexdigest()
                if not no_math_map.has_key(add_value_md5):
                    no_math_map[add_value_md5] = add_editor_key
                    lang_map[csv_data["dir"]+"_index"] = index+1
                else:
                    add_editor_key = no_math_map[add_value_md5]

                csv_data["text_key"] = add_editor_key
                csv_item[4] = add_editor_key
                version_csv_item[4] = add_editor_key

                # lang_json_data[add_editor_key] = csv_data["text"]
                # add_map[add_editor_key] = csv_data["text"]
                if not lang_json_data.has_key(add_editor_key):
                    add_map[add_editor_key] = csv_data["text"]
                    lang_json_data[add_editor_key] = csv_data["text"]

    return add_map



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
    utils.printSplit("读取csv path:" + read_path)
    utils.printSplit("读取csv :" + csv_file)
    # csv_path = os.path.join(ROOT_PATH, csv_file)
    csv_list, header = utils.readCsvFile(read_path, csv_file)
    utils.printObject(csv_list, "CVS READ")
    # utils.printObject(len(csv_list), "CVS READ")
    return csv_list, header


def writeCsv(csv_data, csv_file, csv_head, write_path):
    utils.printSplit("写入csv : " + csv_file)
    csv_path = os.path.join(write_path, csv_file)
    if not csv_head:
        # csv_head = ["文件夹","文件名","控件名","控件文本","Key"]
        csv_head = ["文件名", "控件名", "控件文本", "Key"]
    utils.writeCsvFile(csv_data, csv_path, csv_head)
    utils.printObject(csv_data, "CSV WRITE:")


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

def WriteFontToeditorKey(versionJson, lang):
    versionJson["res/fonts/Font_W7.ttf"] = "i18n/%s/fonts/Font_W7.ttf" % (lang)
    versionJson["res/fonts/Font_W8.ttf"] = "i18n/%s/fonts/Font_W8.ttf" % (lang)

    return versionJson


def main(cfgFile=None):
    # tools/i18n/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # client
    dirClient           = os.path.join(dirScript, os.pardir, os.pardir, os.pardir, "trunk")
    # tools/i18n/csv
    dirCsv              = os.path.join(dirScript, "..", "csv")
    # tools/i18n/json
    dirJson             = os.path.join(dirScript, "..", "json")
    # tools/i18n/base
    dirBase             = os.path.join(dirScript, "..", "base")
    # tools/i18n/package
    dirPackage          = os.path.join(dirScript, "..", "package")
    # tools/i18n/config
    dirConfig           = os.path.join(dirScript, "..", "config")
    #
    dirProject          = os.path.join(dirClient, "cocosstudio")

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
    # cfgNewVersion       = cfgFile["version"][-1]
    # cfgVersionList      = cfgFile["version"]
    cfgVersion          = cfgFile["build"]["version"]

    # dirOutputJson = os.path.join(dirJson, cfgName)
    # utils.mkOutDir(dirOutputJson, False)

    # 配置对应文件夹
    dirCsvCfg = os.path.join(dirCsv, cfgName)
    utils.mkOutDir(dirCsvCfg, False)


    base_csv_file = "base.csv"
    base_csv_list, base_header = readCsv(base_csv_file, dirBase)
    # base_csv_json_list = getParseBaseCsvToJson(base_csv_list)

    base_json_file = "lang.json"
    base_json_data, base_json_name, base_json_path = readJson(base_json_file, dirBase)
    # utils.printObject(lang_json_data, "JSON Export:")

    version = cfgVersion
    if version:
        dirProject = os.path.join(dirClient, "cocosstudio")
        # if version["path"] != "trunk":
        #     dirProject = os.path.join(dirClient, version["path"], "cocosstudio")

        versionCsv = "%s_%s_main.csv" % (version["name"], version["svn"])
        versionAddCsv = "%s_%s_add_list.csv" % (version["name"], version["svn"])
        versionMainJson = "%s_%s_main.json" % (version["name"], version["svn"])
        versionLangJson = "%s_%s_lang.json" % (version["name"], version["svn"])
        versionLangAddJson = "%s_%s_add_list.json" % (version["name"], version["svn"])
        versionAddList = []
        isAddActive = False

        if os.path.exists(os.path.join(dirCsvCfg, versionMainJson)):
            version_main_json_data, _, _ = readJson(versionMainJson, dirCsvCfg)
            isAddActive = version_main_json_data["isActive"]
        
        utils.printObject(isAddActive, "版本添加内容是否激活 isActive:")

        if isAddActive and os.path.exists(os.path.join(dirCsvCfg, versionAddCsv)):
            version_add_list, add_header = readCsv(versionAddCsv, dirCsvCfg)
            versionAddList = version_add_list
            # 合并元素到原始表
            base_csv_list.extend(version_add_list) 
            writeCsv(base_csv_list, base_csv_file, base_header, dirBase)
            # os.remove(os.path.join(dirCsvCfg, versionAddCsv))


        if isAddActive and os.path.exists( os.path.join(dirCsvCfg, versionCsv) ):
            
            version_csv_list, header = readCsv(versionCsv, dirCsvCfg)

            addLenth = len(versionAddList)
            utils.printObject(addLenth, "版本新添加内容长度 len:")
            utils.printObject(versionLangJson, "versionLangJson:")

            if addLenth > 0:
                add_map = parseVerionAddCsdWithCsv(version_csv_list, base_json_data, versionAddList)
                versionLangJsonData = WriteFontToeditorKey(base_json_data, cfgLang)

                # return
                #更新写入版本csd中文本
                writeCsv(version_csv_list, versionCsv, header, dirCsvCfg)
    
                # 写入版本对应中文 editor文本
                dirPackageCfg = os.path.join(dirPackage, cfgName)
                utils.mkOutDir(dirPackageCfg, False)
                # 写入版本对应中文 editor文本
                writeJson(versionLangJsonData, versionLangJson, dirPackageCfg)
                writeJson(base_json_data, base_json_file, dirBase)
                # 写入版本对应增加的中文 editor文本
                writeJson(add_map, versionLangAddJson, dirPackageCfg)

                if os.path.exists(os.path.join(dirPackageCfg, versionLangJson)):
                    langJsonPath = os.path.join(dirProject,"src", "app", "i18n", cfgLang)
                    utils.mkOutDir(langJsonPath, False)
                    utils.copyFile(os.path.join(dirPackageCfg, versionLangJson), os.path.join(langJsonPath,"editor_key.json"))

            parseVersionCsvKeyResetToCsd(version_csv_list, dirProject)

        if not isAddActive:
            if os.path.exists(os.path.join(dirCsvCfg, versionAddCsv)):
                utils.error("请先检查 %s 中 csd文件文本是否有效。 若已经检查过请把%s中isActive 设置为True" % (versionAddCsv, versionMainJson) )
            else:
                utils.error("请检查 %s 中 isActive 是否为 True" % versionMainJson)

    


if __name__ == "__main__":
    utils.runMain(main)
