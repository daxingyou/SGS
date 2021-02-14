#!/usr/bin/env python
# coding=utf-8

import os
import platform
import re
import utils
import shutil
import json
import sys
import getopt
import datetime
from distutils.version import LooseVersion

def getLang(cfgLang, key):
    if cfgLang.has_key(key):
        lang = cfgLang[key]
        return lang.decode("utf-8").encode("gbk")
    return "null"

def main(cfgFile=None):
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirSimulator        = os.path.join(dirScript, "..", "..")
    cfgLang             = utils.getJson(os.path.join(dirScript, "lang.json"))

    ignores = [".svn", "tools"]
    # works = ["tags","trunk"]
    works = list()
    branchs = list()
    configs = list()
    file_list = os.listdir(dirSimulator)
    for f in file_list:
        full_path = os.path.join(dirSimulator, f)
        if os.path.isdir(full_path):
            if not f in ignores:
                works.append(f)

    #
    print(" ")
    utils.printSplit(getLang(cfgLang, "lang8"))
    for index,value in enumerate(works):
        print("    %d: %s" %(index, os.path.splitext(value)[0]))

    while True:
        choice_work = input(getLang(cfgLang, "lang9"))
        if choice_work > len(works):
            print(getLang(cfgLang, "lang10"))
        else:
            break

    file_list = os.listdir(os.path.join(dirSimulator,works[choice_work]))
    for f in file_list:
        full_path = os.path.join(dirSimulator,works[choice_work], f)
        if os.path.isdir(full_path):
            # if not f in ignores:
            branchs.append(f)

    file_list = os.listdir(dirConfig)
    for f in file_list:
        full_path = os.path.join(dirConfig, f)
        if os.path.isfile(full_path):
            configs.append(f)

    #
    print(" ")
    utils.printSplit(getLang(cfgLang, "lang1"))
    for index,value in enumerate(branchs):
        print("    %d: %s" %(index, value))

    while True:
        choice_branch = input(getLang(cfgLang, "lang2"))
        if choice_branch > len(branchs):
            print(getLang(cfgLang, "lang5"))
        else:
            break
    
    print("%d is a %s" % (index, value))
    os.path.dirname()
    file_name = ["", "", ""]
    file_name2 = ("", "", "")
    fiel_name3 = {"" : "", "":123}
    file_name.append() 
    del file_name[1]  len(t) t.append() del t[5]  t[1:3]

    #
    print(" ")
    utils.printSplit(getLang(cfgLang, "lang3"))
    for index,value in enumerate(configs):
        print("    %d: %s" %(index, os.path.splitext(value)[0]))

    while True:
        choice_config = input(getLang(cfgLang, "lang4"))
        if choice_config > len(configs):
            print(getLang(cfgLang, "lang6"))
        else:
            break

    #
    dirBranchConfig = os.path.join(dirSimulator, works[choice_work], branchs[choice_branch], "cocosstudio", "simulator", "config", "url.lua")
    dirChoiceConfig = os.path.join(dirConfig, configs[choice_config])

    shutil.copy(dirChoiceConfig, dirBranchConfig)
    print(" ")
    print("%s%s%s%s" % (works[choice_work], branchs[choice_branch], getLang(cfgLang, "lang7"), os.path.splitext(configs[choice_config])[0]))

if __name__ == "__main__":
    utils.runMain(main)
