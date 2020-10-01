#!/usr/bin/python
# ----------------------------------------------------------------------------
# cocos "luacompile" plugin
#
# Copyright 2013 (C) Intel
#
# License: MIT
# ----------------------------------------------------------------------------

'''
"luacompile" plugin for cocos command line tool
'''

__docformat__ = 'restructuredtext'

import sys
import subprocess
import os
import json
import inspect
import shutil
from contextlib import contextmanager

############################################################ 
#http://www.coolcode.org/archives/?article-307.html
############################################################ 

import struct 

_DELTA = 0x9E3779B9  

def _long2str(v, w):  
    n = (len(v) - 1) << 2  
    if w:  
        m = v[-1]  
        if (m < n - 3) or (m > n): return ''  
        n = m  
    s = struct.pack('<%iL' % len(v), *v)  
    return s[0:n] if w else s  
  
def _str2long(s, w):  
    n = len(s)  
    m = (4 - (n & 3) & 3) + n  
    s = s.ljust(m, "\0")  
    v = list(struct.unpack('<%iL' % (m >> 2), s))  
    if w: v.append(n)  
    return v  
  
def encrypt(str, key):  
    if str == '': return str  
    v = _str2long(str, True)  
    k = _str2long(key.ljust(16, "\0"), False)  
    n = len(v) - 1  
    z = v[n]  
    y = v[0]  
    sum = 0  
    q = 6 + 52 // (n + 1)  
    while q > 0:  
        sum = (sum + _DELTA) & 0xffffffff  
        e = sum >> 2 & 3  
        for p in xrange(n):  
            y = v[p + 1]  
            v[p] = (v[p] + ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z))) & 0xffffffff  
            z = v[p]  
        y = v[0]  
        v[n] = (v[n] + ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^ (sum ^ y) + (k[n & 3 ^ e] ^ z))) & 0xffffffff  
        z = v[n]  
        q -= 1  
    return _long2str(v, False)  
  
def decrypt(str, key):  
    if str == '': return str  
    v = _str2long(str, False)  
    k = _str2long(key.ljust(16, "\0"), False)  
    n = len(v) - 1  
    z = v[n]  
    y = v[0]  
    q = 6 + 52 // (n + 1)  
    sum = (q * _DELTA) & 0xffffffff  
    while (sum != 0):  
        e = sum >> 2 & 3  
        for p in xrange(n, 0, -1):  
            z = v[p - 1]  
            v[p] = (v[p] - ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z))) & 0xffffffff  
            y = v[p]  
        z = v[n]  
        v[0] = (v[0] - ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4) ^ (sum ^ y) + (k[0 & 3 ^ e] ^ z))) & 0xffffffff  
        y = v[0]  
        sum = (sum - _DELTA) & 0xffffffff  
    return _long2str(v, True)  

@contextmanager
def pushd(newDir):
    previousDir = os.getcwd()
    os.chdir(newDir)
    yield
    os.chdir(previousDir)

#import cocos
class CCPluginLuaCompile():
    """
    compiles (encodes) and minifies Lua files
    """
    @staticmethod
    def plugin_name():
        return "luacompile"

    @staticmethod
    def brief_description():
        # returns a short description of this module
        return 'LUACOMPILE_BRIEF'

    # This is not the constructor, just an initializator
    def init(self, options, workingdir):
        """
        Arguments:
        - `options`:
        """
        self._current_src_dir = None
        self._src_dir_arr = self.normalize_path_in_list(options.src_dir_arr)
        self._dst_dir = options.dst_dir
        if not os.path.isabs(self._dst_dir):
            self._dst_dir = os.path.abspath(self._dst_dir)
        self._verbose = options.verbose
        self._workingdir = workingdir
        self._lua_files = {}
        self._isEncrypt = options.encrypt
        self._encryptkey = options.encryptkey
        self._encryptsign = options.encryptsign
        self._bytecode_64bit = options.bytecode_64bit

        self._luajit_exe_path = self.get_luajit_path()
        self._disable_compile = options.disable_compile

        if self._luajit_exe_path is None:
            raise Exception("Can't find right luajit for current system.")

        self._luajit_dir = os.path.dirname(self._luajit_exe_path)

    def normalize_path_in_list(self, list):
        for i in list:
            tmp = os.path.normpath(i)
            if not os.path.isabs(tmp):
                tmp = os.path.abspath(tmp)
            list[list.index(i)] = tmp
        return list

    def get_relative_path(self, luafile):
        try:
            pos = luafile.index(self._current_src_dir)
            if pos != 0:
                raise Exception("Can't find src directory in file path.")

            return luafile[len(self._current_src_dir)+1:]
        except ValueError:
            raise Exception("Can't find src directory in file path.")

    def get_output_file_path(self, luafile):
        """
        Gets output file path by source lua file
        """
        # create folder for generated file
        luac_filepath = ""
        # Unknow to remove 'c' 
        relative_path = self.get_relative_path(luafile)+"c"
        luac_filepath = os.path.join(self._dst_dir, relative_path)

        dst_rootpath = os.path.split(luac_filepath)[0]
        try:
            # print "creating dir (%s)" % (dst_rootpath)
            os.makedirs(dst_rootpath)
        except OSError:
            if os.path.exists(dst_rootpath) == False:
                # There was an error on creation, so make sure we know about it
                raise Exception("Error: create directory %s failed." % dst_rootpath)

        # print "return luac path: "+luac_filepath
        return luac_filepath

    def get_luajit_path(self):
        ret = None

        bit_prefix = "64bit" if self._bytecode_64bit else "32bit"
        if sys.platform == 'win32':
            ret = os.path.join(self._workingdir,"..","external", "luajit", bit_prefix, "luajit-win32.exe")
        elif sys.platform == 'darwin':
            ret = os.path.join(self._workingdir,"..","external", "luajit", bit_prefix, "luajit-mac")
            os.popen("chmod 777 %s" % (ret)).read()
        elif 'linux' in sys.platform:
            ret = os.path.join(self._workingdir,"..","external", "luajit", bit_prefix, "luajit-linux")

        print("luajit bin path: " + ret)
        return ret

    def compile_lua(self, lua_file, output_file):
        """
        Compiles lua file
        """
        print("Compiling lua (%s) to bytecode..." % lua_file)

        with pushd(self._luajit_dir):
            cmd_str = "\"%s\" -b \"%s\" \"%s\"" % (self._luajit_exe_path, lua_file, output_file)
            try:
                ret = subprocess.check_output(cmd_str,
                                stderr = subprocess.STDOUT,
                                shell = True)
            except subprocess.CalledProcessError, exc:
                print 'returncode:', exc.returncode
                print 'output:', exc.output

    # TODO
    # def compress_js(self):
    def deep_iterate_dir(self, rootDir):
        for lists in os.listdir(rootDir):
            path = os.path.join(rootDir, lists)
            if os.path.isdir(path):
                self.deep_iterate_dir(path)
            elif os.path.isfile(path):
                if os.path.splitext(path)[1] == ".lua":
                    self._lua_files[self._current_src_dir].append(path)

    # UNDO
    # def index_in_list(self, lua_file, l):
    # def lua_filename_pre_order_compare(self, a, b):
    # def lua_filename_post_order_compare(self, a, b):
    # def _lua_filename_compare(self, a, b, files, delta):
    # def reorder_lua_files(self):

    def handle_all_lua_files(self):
        """
        Arguments:
        - `self`:
        """

        print("Processing lua script files")
        index = 0
        for src_dir in self._src_dir_arr:
            for lua_file in self._lua_files[src_dir]:
                self._current_src_dir = src_dir
                dst_lua_file = self.get_output_file_path(lua_file)
                if self._disable_compile:
                    shutil.copy(lua_file, dst_lua_file)
                else:
                    self.compile_lua(lua_file, dst_lua_file)                   

                if self._isEncrypt == True:
                    bytesFile = open(dst_lua_file, "rb+")
                    encryBytes = encrypt(bytesFile.read(), self._encryptkey)
                    encryBytes = self._encryptsign + encryBytes
                    bytesFile.seek(0)
                    bytesFile.write(encryBytes)
                    bytesFile.close()
                    index = index + 1



    def run(self, argv, dependencies):
        """
        """
        self.parse_args(argv)

        # tips
        print("By using luacompile, you could precompile the Lua script files to the bytecode files and encrypt the Lua script files or the bytecode files by XXTEA.")
        # create output directory
        try:
            os.makedirs(self._dst_dir)
        except OSError:
            if os.path.exists(self._dst_dir) == False:
                raise Exception("Error: create directory %s failed." % self._dst_dir)

        # deep iterate the src directory
        for src_dir in self._src_dir_arr:
            self._current_src_dir = src_dir
            self._lua_files[self._current_src_dir] = []
            self.deep_iterate_dir(src_dir)

        self.handle_all_lua_files()

        print("Compilation finished.")

    def parse_args(self, argv):
        """
        """

        from argparse import ArgumentParser

        parser = ArgumentParser(prog="cocos %s" % self.__class__.plugin_name(),
                                description=self.__class__.brief_description())

        parser.add_argument("-v", "--verbose",
                          action="store_true",
                          dest="verbose",
                          help='LUACOMPILE_ARG_VERBOSE')
        parser.add_argument("-s", "--src", dest="src_dir_arr",
                          action="append", help='LUACOMPILE_ARG_SRC')
        parser.add_argument("-d", "--dst", dest="dst_dir",
                          help='LUACOMPILE_ARG_DST')
        parser.add_argument("-e", "--encrypt",
                          action="store_true", dest="encrypt",default=False,
                          help='LUACOMPILE_ARG_ENCRYPT')
        parser.add_argument("-k", "--encryptkey",
                          dest="encryptkey",default="2dxLua",
                          help='LUACOMPILE_ARG_ENCRYPT_KEY')
        parser.add_argument("-b", "--encryptsign",
                          dest="encryptsign",default="XXTEA",
                          help='LUACOMPILE_ARG_ENCRYPT_SIGN')
        parser.add_argument("--disable-compile",
                          action="store_true", dest="disable_compile", default=False,
                          help='LUACOMPILE_ARG_DISABLE_COMPILE')
        parser.add_argument("--bytecode-64bit",
                          action="store_true", dest="bytecode_64bit", default=False,
                          help='LUACOMPILE_ARG_BYTECODE_64BIT')
        print(argv)
        options = parser.parse_args(argv)

        if options.src_dir_arr == None:
            raise Exception("Error: Please set source folder by '-s' or '--src'.")
        elif options.dst_dir == None:
            raise Exception("Error: Please set destination folder by '-d' or '--dst'.")
        else:
            for src_dir in options.src_dir_arr:
                if os.path.exists(src_dir) == False:
                    raise Exception("Error: %s is not existed." % src_dir)

        # script directory
        if getattr(sys, 'frozen', None):
            workingdir = os.path.realpath(os.path.dirname(sys.executable))
        else:
            workingdir = os.path.realpath(os.path.dirname(__file__))

        self.init(options, workingdir)








