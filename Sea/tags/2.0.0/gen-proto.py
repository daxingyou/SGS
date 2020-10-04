#!/usr/bin/env python
# coding=utf-8

import os
import sys
import platform
import re
import StringIO
import collections


def initUtf8():
    import sys
    reload(sys)
    sys.setdefaultencoding('utf8')


def encode(d, f=None, index=0):
    if f is None:
        f = StringIO.StringIO()

    # if index == 0:
    #     f.write('return ')
    sep = ''
    tab = " " * 4
    f.write("{\n")
    if isinstance(d, list):
        for v in d:
            f.write(sep)
            if sep == '':
                sep = ',\n'
            f.write(tab * (index + 1))
            if v is None:
                continue
            elif isinstance(v, list) or isinstance(v, collections.OrderedDict):
                encode(v, f, index + 1)
            else:
                if isinstance(v, int):
                    f.write('%d' % v)
                elif isinstance(v, float):
                    f.write('%.8f' % v)
                else:
                    v = v.replace('\n', '\\n')
                    f.write('"%s"' % v)
    elif isinstance(d, collections.OrderedDict):
        for k, v in d.iteritems():
            f.write(sep)
            if sep == '':
                sep = ',\n'
            f.write(tab * (index + 1))
            if isinstance(k, int):
                f.write('[%d]' % k)
            else:
                f.write(k)
            f.write(' = ')
            if v is None:
                f.write('nil')
            elif isinstance(v, list) or isinstance(v, collections.OrderedDict):
                encode(v, f, index + 1)
            else:
                if isinstance(v, int):
                    f.write('%d' % v)
                elif isinstance(v, float):
                    f.write('%.8f' % v)
                else:
                    v = v.replace('\n', '\\n')
                    f.write('"%s"' % v)
    f.write("\n" + tab * index + "}")
    if index == 0:
        f.seek(0)
        buf = f.read()
        f.close()
        return buf



def parse_command(f):
    ret = None
    service = None
    package = None
    while True:
        line = f.readline()
        if not line:
            return ret
        if package is None:
            pattern = "package[\s\t](\w+)"
            r = re.search(pattern, line)
            if r:
                package = r.group(1)
            continue
        if ret is None:
            pattern = "enum[\s\t]*ID[\s\t]*\{.*"
            r = re.search(pattern, line)
            if r:
                ret = collections.OrderedDict()
            continue
        pattern = "\}.*"
        r = re.search(pattern, line)
        if r:
            return ret

        pattern = "[\s\t]*ID_(\w+)[\s\t]*=[\s\t]*(\d+).*"
        r = re.search(pattern, line)
        if r:
            commandName = r.group(1)
           
            ret[package + r.group(2)] = package + "." + commandName
    return ret


def parse_common(f):
    ret = None
    service = None
    while True:
        line = f.readline()
        if not line:
            return ret
        if ret is None:
            pattern = "enum[\s\t]*ID[\s\t]*\{.*"
            r = re.search(pattern, line)
            if r:
                ret = collections.OrderedDict()
            continue
        pattern = "\}.*"
        r = re.search(pattern, line)
        if r:
            return ret

        pattern = "[\s\t]*(\w+)[\s\t]*=[\s\t]*(\d+).*"
        r = re.search(pattern, line)
        if r:
            ret[r.group(1)] = int(r.group(2))
    return ret


def fun():
    DIR = os.path.dirname(os.path.abspath(__file__))
    DIR_PROTO = os.path.realpath(os.path.join(DIR, "cocosstudio", "res", "proto"))
    DIR_OUT = os.path.realpath(os.path.join(DIR, "cocosstudio", "src", "app", "const"))
    

    filename = os.path.join(DIR_PROTO, "cs.proto")
    
    f = open(filename, "r")
    data = parse_command(f)
    open(os.path.join(DIR_OUT, "MessageConst.lua"), "w").write("return " + encode(data))
    f.close()

    f = open(filename, "r")
    data = parse_common(f)
    open(os.path.join(DIR_OUT, "MessageIDConst.lua"), "w").write("return " + encode(data))
    f.close()

def main():
    initUtf8()

    try:
        fun()
    finally:
        if platform.system() == "Windows":
            print('Press any key to continue...')
            raw_input()


if __name__ == '__main__':
    main()
