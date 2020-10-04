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
        print csd_path
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
        _csd_list = utils.getFilesWithName(csd_root_dir, _csd)
        full_path = os.path.join(csd_root_dir, _path)
        if _name != None and _name != "" and full_path != None:
            utils.printObject(full_path, "csv csd full_path:")
            csdParse = Csd()
            csdParse.load(full_path)
            print(_csd + "  node" + _name + "  last: " + csdParse.getNodeText(_name, _text_path))
            # csdParse.setNodeText(_name, "")
            setCsdNodeString(csdParse, _name, _text_key, _text_path)
            print(_csd + "  node" + _name + "  now: " + csdParse.getNodeText(_name, _text_path))
            csdParse.save()
    pass


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
    # cfgNewVersion       = cfgFile["version"][-1]
    # cfgVersionList      = cfgFile["version"]
    cfgVersion          = cfgFile["build"]["version"]

    # dirOutputJson = os.path.join(dirJson, cfgName)
    # utils.mkOutDir(dirOutputJson, False)

    dirProjectCsv = os.path.join(dirCsv, cfgName)
    utils.mkOutDir(dirProjectCsv, False)

    version = cfgVersion
    if version:
        dirProject = os.path.join(dirClient, "cocosstudio")
        # if version["path"] != "trunk":
        #     dirProject = os.path.join(dirClient, version["path"], "cocosstudio")

        # fileVersionCsv = os.path.join(dirProjectCsv, "%s_%s_main.csv" % (version["name"], version["svn"]))
        # fileVersionJson = os.path.join(dirProjectCsv, "%s_%s_main.json" % (version["name"], version["svn"]))
        fileVersionCsv = "%s_%s_main.csv" % (version["name"], version["svn"])
        if os.path.exists( os.path.join(dirProjectCsv, fileVersionCsv) ):
            
            version_csv_list, header = readCsv(fileVersionCsv, dirProjectCsv)
            parseVersionCsvKeyResetToCsd(version_csv_list, dirProject)


    


if __name__ == "__main__":
    utils.runMain(main)
