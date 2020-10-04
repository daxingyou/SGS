#!/usr/bin/env python
# coding=utf-8

import os
import collections
import utils
import librosa

AUDIOTYPE = ".mp3"

def main():
    mp3Folder = raw_input("Enter your audio folder path: ")
    if not os.path.exists(mp3Folder):
        print mp3Folder+" is not exists"
        return
    csvName = os.path.join(mp3Folder,"result.csv")
    csvTab = []
    for dirpath, dirnames, filenames in os.walk(mp3Folder):
        for filename in filenames:
            dic = os.path.splitext(filename)
            name = dic[0]
            ext = dic[1]
            if ext.lower() == AUDIOTYPE:
                filepath = os.path.join(dirpath,filename)
                time = librosa.get_duration(filename=filepath)
                print name,time*1000
                csvTab.append([name,time*1000])
    csvHead = ["file", "length"]
    utils.writeCsvFile(csvTab, csvName, csvHead)


if __name__ == "__main__":
    utils.runMain(main)
