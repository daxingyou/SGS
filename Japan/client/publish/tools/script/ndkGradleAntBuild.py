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
from xml.dom import minidom


def check_environment_variable(var):
    try:
        value = os.environ[var]
    except Exception:
        print "check_environment_variable %s not found"%var

    return value

def remove_c_libs(libs_dir):
    for file_name in os.listdir(libs_dir):
        lib_file = os.path.join(libs_dir,  file_name)
        if os.path.isfile(lib_file):
            ext = os.path.splitext(lib_file)[1]
            if ext == ".a" or ext == ".so":
                os.remove(lib_file)

def add_path_prefix(path_str):
    if platform.system() != "Windows":
        return path_str

    if path_str.startswith("\\\\?\\"):
        return path_str

    ret = "\\\\?\\" + os.path.abspath(path_str)
    ret = ret.replace("/", "\\")
    return ret

def copy_files_in_dir(src, dst):

    for item in os.listdir(src):
        path = os.path.join(src, item)
        if os.path.isfile(path):
            path = add_path_prefix(path)
            copy_dst = add_path_prefix(dst)
            shutil.copy(path, copy_dst)
        if os.path.isdir(path):
            new_dst = os.path.join(dst, item)
            if not os.path.isdir(new_dst):
                os.makedirs(add_path_prefix(new_dst))
            copy_files_in_dir(path, new_dst)

def copy_files_with_rules(src_rootDir, src, dst):
    if os.path.isfile(src):
        if not os.path.exists(dst):
            os.makedirs(add_path_prefix(dst))

        copy_src = add_path_prefix(src)
        copy_dst = add_path_prefix(dst)
        shutil.copy(copy_src, copy_dst)
        return

    if not os.path.exists(dst):
        os.makedirs(add_path_prefix(dst))
    copy_files_in_dir(src, dst)

def copy_files_with_config(config, src_root, dst_root):
    src_dir = config["from"]
    dst_dir = config["to"]

    src_dir = os.path.join(src_root, src_dir)
    dst_dir = os.path.join(dst_root, dst_dir)

    copy_files_with_rules(
        src_dir, src_dir, dst_dir)

def gradle_build_apk(build_mode, android_platform):
    # check the compileSdkVersion
    sdk_root = check_environment_variable( sdk_root_str )
    check_path = os.path.join(sdk_root, 'platforms', android_platform)
    if not os.path.isdir(check_path):
        raise Exception('sdk %s not found in %s'%(android_platform,sdk_root))

    # invoke gradlew for gradle building
    if platform.system() == "Windows":
        gradle_path = os.path.join(projectPath, 'gradlew.bat')
    else:
        gradle_path = os.path.join(projectPath, 'gradlew')

    if not os.path.isfile(gradle_path):
        raise Exception('gradlew not exit')

    cmdClean = "cd %s && chmod +x ./gradlew && ./gradlew clean" % (projectPath)
    print cmdClean
    outputClean = os.popen(cmdClean).read()
    print outputClean

    mode_str = 'Debug' if build_mode == 'debug' else 'Release'
    cmdBuild = 'cd %s && "%s" --parallel --info assemble%s' % (projectPath, gradle_path, mode_str)
    print cmdBuild
    outputBuild = os.popen(cmdBuild).read()
    print outputBuild

def ant_build_apk(build_mode):
    sdk_root = check_environment_variable( sdk_root_str )
    ant_root = check_environment_variable('ANT_ROOT')
    ant_path = os.path.join(ant_root, 'ant')
    buildfile_path = os.path.join(projectPath, "build.xml")
    cmdBuild = '%s clean %s -f %s -Dsdk.dir=%s' % (ant_path, build_mode,os.path.abspath(buildfile_path), sdk_root)
    print cmdBuild
    outputBuild = os.popen(cmdBuild).read()
    print outputBuild


def xml_attr(dir, file_name, node_name, attr):
    doc = minidom.parse(os.path.join(dir, file_name))
    return doc.getElementsByTagName(node_name)[0].getAttribute(attr)

def do_build_apk(build_mode,android_platform):
    if useStudio:
        assets_dir = os.path.join(projectPath, "app", "assets")
        project_name = None
        setting_file = os.path.join(projectPath, 'settings.gradle')
        if os.path.isfile(setting_file):
            # get project name from settings.gradle
            f = open(setting_file)
            lines = f.readlines()
            f.close()

            pattern = r"project\(':(.*)'\)\.projectDir[ \t]*=[ \t]*new[ \t]*File\(settingsDir, 'app'\)"
            for line in lines:
                line_str = line.strip()
                match = re.match(pattern, line_str)
                if match:
                    project_name = match.group(1)
                    break

        if project_name is None:
            # use default project name
            project_name = 'app'
        gen_apk_folder = os.path.join(projectPath, 'app/build/outputs/apk',build_mode)
    else:
        assets_dir = os.path.join(projectPath, "assets")
        project_name = xml_attr(projectPath, 'build.xml', 'project', 'name')
        gen_apk_folder = os.path.join(projectPath, 'bin')

    # copy resources
    if os.path.isdir(assets_dir):
        shutil.rmtree(assets_dir)

    if build_cfg_json.has_key('must_copy_resources'):
        res_files = build_cfg_json['must_copy_resources'] + build_cfg_json['copy_resources']
    else:
        res_files = build_cfg_json['copy_resources']
    for cfgRes in res_files:
        copy_files_with_config(cfgRes, projectPath, assets_dir)

    # build apk
    if useStudio:
        gradle_build_apk(build_mode, android_platform)
    else:
        ant_build_apk(build_mode)

    utils.mkOutDir(dirRuntime,False,[])
    apk_name = '%s-%s.apk' % (project_name, build_mode)
    gen_apk_path = os.path.join(gen_apk_folder, apk_name)
    runtime_apk_path = os.path.join(dirRuntime, apk_name)
    if build_mode == "release":
        signed_name = "%s-%s-signed.apk" % (project_name, build_mode)
        runtime_apk_path = os.path.join(dirRuntime, signed_name)
    shutil.copy(gen_apk_path, runtime_apk_path)

def update_project_properties(target_str):
    props_path = os.path.join(ndk_work_dir, 'project.properties')
    f = open(props_path)
    lines = f.readlines()
    f.close()

    pattern = r'^target=(.*)$'
    matched = False
    new_line = 'target=%s\n' % target_str
    for i in range(0, len(lines)):
        l = lines[i]
        match = re.match(pattern, l.strip())
        if match:
            lines[i] = new_line
            matched = True

    if not matched:
        lines.append('\n')
        lines.append(new_line)

    f = open(props_path, 'w')
    f.writelines(lines)
    f.close()

def update_lib_projects(target_str, property_path):
    property_file = os.path.join(property_path, "project.properties")
    if not os.path.isfile(property_file):
        return

    sdk_root = check_environment_variable( sdk_root_str )
    sdk_tool_path = os.path.join(sdk_root, 'tools', 'android')

    patten = re.compile(r'^android\.library\.reference\.[\d]+=(.+)')
    for line in open(property_file):
        str1 = line.replace(' ', '')
        str2 = str1.replace('\t', '')
        match = patten.match(str2)
        if match is not None:
            # a lib project is found
            lib_path = match.group(1)
            abs_lib_path = os.path.join(property_path, lib_path)
            abs_lib_path = os.path.normpath(abs_lib_path)
            if os.path.isdir(abs_lib_path):
                command = "%s update lib-project -p %s -t %s" % (sdk_tool_path, abs_lib_path, target_str)
                outcommand = os.popen(command).read()
                print outcommand
                update_lib_projects(target_str, abs_lib_path)

def write_local_properties():
    local_porps_path = os.path.join(projectPath, 'local.properties')
    sdk_dir = check_environment_variable(sdk_root_str)
    ndk_dir = check_environment_variable('NDK_ROOT')
    if platform.system() == "Windows":
        # On Windows, the path should be like:
        # sdk.dir = C:\\path\\android-sdk
        sdk_dir = sdk_dir.replace('\\', '\\\\')
        ndk_dir = ndk_dir.replace('\\', '\\\\')
    lines = [
        'sdk.dir=%s\n' % sdk_dir,
        'ndk.dir=%s\n' % ndk_dir
    ]
    f = open(local_porps_path, 'w')
    f.writelines(lines)
    f.close()


def do_ndk_build(input_abi,build_mode,bCompatible):
    ndk_root = check_environment_variable('NDK_ROOT')
    toolchain_version = '4.9'
    if 'NDK_TOOLCHAIN_VERSION' in os.environ:
        toolchain_version = os.environ['NDK_TOOLCHAIN_VERSION']

    reload(sys)
    sys.setdefaultencoding('utf8')
    
    #
    build_cfg_path = os.path.join(projectPath, "build-cfg.json")

    ndk_module_paths = build_cfg_json['ndk_module_path']

    move_cfg = {}
    if build_cfg_json.has_key('key_store'):
        move_cfg[key_store_str] = build_cfg_json['key_store']
        del build_cfg_json['key_store']

    if build_cfg_json.has_key('key_store_pass'):
        move_cfg[key_store_pass_str] = build_cfg_json['key_store_pass']
        del build_cfg_json['key_store_pass']

    if build_cfg_json.has_key('alias'):
        move_cfg[key_alias_str] = build_cfg_json['alias']
        del build_cfg_json['alias']

    if build_cfg_json.has_key('alias_pass'):
        move_cfg[key_alias_pass_str] = build_cfg_json['alias_pass']
        del build_cfg_json['alias_pass']
    if len(move_cfg) > 0:
        file_obj = open(sign_prop_file, "w+")
        for key in move_cfg.keys():
            str_cfg = "%s=%s\n" % (key, move_cfg[key])
            file_obj.write(str_cfg)
        file_obj.close()
        with open(build_cfg_path, 'w') as outfile:
            json.dump(build_cfg_json, outfile, sort_keys = True, indent = 4)
            outfile.close()


    module_paths = []
    for cfg_path in ndk_module_paths:
        if cfg_path.find("${COCOS_X_ROOT}") >= 0:
            cocos_root = check_environment_variable("COCOS_X_ROOT")
            module_paths.append(os.path.normpath(cfg_path.replace("${COCOS_X_ROOT}", cocos_root)))
        elif cfg_path.find("${COCOS_FRAMEWORKS}") >= 0:
            cocos_frameworks = check_environment_variable("COCOS_FRAMEWORKS")
            module_paths.append(os.path.normpath(cfg_path.replace("${COCOS_FRAMEWORKS}", cocos_frameworks)))
        else:
            module_paths.append(os.path.normpath(os.path.join(projectPath, cfg_path)))
    # print module_paths

    # delete template static and dynamic files
    obj_local_dir = os.path.join(ndk_work_dir, "obj", "local")
    if os.path.isdir(obj_local_dir):
        for abi_dir in os.listdir(obj_local_dir):
            static_file_path = os.path.join(ndk_work_dir, "obj", "local", abi_dir)
            if os.path.isdir(static_file_path):
                remove_c_libs(static_file_path)

    # windows should use ";" to seperate module paths
    if platform.system() == "Windows":
        ndk_module_path = ';'.join(module_paths)
    else:
        ndk_module_path = ':'.join(module_paths)
    
    ndk_module_path= 'NDK_MODULE_PATH=' + ndk_module_path

    jobs = 8
    ndk_build_param = [
        "-j%s" % jobs
    ]

    app_abi = " ".join(input_abi.split(":"))
    abi_param = "APP_ABI=\"%s\"" % app_abi
    ndk_build_param.append(abi_param)
    ndk_path = os.path.join(ndk_root, "ndk-build")
    ndk_build_cmd = '%s -C %s %s %s' % (ndk_path, ndk_work_dir, ' '.join(ndk_build_param), ndk_module_path)

    ndk_build_cmd = '%s NDK_TOOLCHAIN_VERSION=%s' % (ndk_build_cmd, toolchain_version)

    build_mode = 'debug'
    if build_mode == 'debug':
        ndk_build_cmd = '%s NDK_DEBUG=1 V=1' % ndk_build_cmd
    if bCompatible:
        ndk_build_cmd = '%s APP_PLATFORM=android-19' % ndk_build_cmd
    print ndk_build_cmd
    output = os.popen(ndk_build_cmd).read()
    print output


projectPath = ""
ndk_work_dir = ""
build_cfg_json = None
sign_prop_file = ""
key_store_str = "key.store"
key_alias_str = "key.alias"
key_store_pass_str = "key.store.password"
key_alias_pass_str = "key.alias.password"
useStudio = False
sdk_root_str = "ANDROID_SDK_ROOT"
dirRuntime = ""
def startBuild(build_mode, android_platform, input_abi, use_studio, compatible):
    # publish/tools/script
    dirScript           = os.path.dirname(utils.getExecPath())
    # publish/xgame
    dirProject          = os.path.join(dirScript, "..", "..", "xgame")
    # publish/xgame/frameworks
    dirProjectFramework = os.path.join(dirProject, "frameworks")

    global dirRuntime
    global projectPath
    global ndk_work_dir
    global build_cfg_json
    global sign_prop_file
    global key_store_str
    global key_alias_str
    global key_store_pass_str
    global key_alias_pass_str
    global useStudio
    global sdk_root_str

    dirRuntime          = os.path.join(dirScript, "..", "..", "xgame", "simulator", "android")
    if build_mode == "release":
        dirRuntime = os.path.join(dirScript, "..", "..", "xgame", "publish", "android")

    useStudio = use_studio
    if use_studio:
        # publish/xgame/frameworks/runtime-src/proj.android-studio
        projectPath = os.path.join(dirProjectFramework, "runtime-src","proj.android-studio")
        ndk_work_dir =  os.path.join(projectPath, "app")
        sign_prop_file = os.path.join(ndk_work_dir, "gradle.properties")
        key_store_str = "RELEASE_STORE_FILE"
        key_alias_str = "RELEASE_KEY_ALIAS"
        key_store_pass_str = "RELEASE_STORE_PASSWORD"
        key_alias_pass_str = "RELEASE_KEY_PASSWORD"
        sdk_root_str = "ANDROIDSTUDIO_SDK_ROOT"
    else:
        # publish/xgame/frameworks/runtime-src/proj.android
        projectPath = os.path.join(dirProjectFramework, "runtime-src","proj.android")
        ndk_work_dir =  projectPath
        sign_prop_file = os.path.join(projectPath, "ant.properties")
        sdk_root_str = "ANDROID_SDK_ROOT"

    build_cfg_path = os.path.join(projectPath, "build-cfg.json")
    f = open(build_cfg_path)
    build_cfg_json = json.load(f, encoding='utf8')
    f.close()

    write_local_properties()
    update_project_properties(android_platform)
    update_lib_projects(android_platform,ndk_work_dir)

    #兼容低端机，compatible==True，ndk先编译android-19再根据android_platform编译，compatible==False，ndk只根据android_platform编译
    if compatible:
        do_ndk_build(input_abi, build_mode, True)
    do_ndk_build(input_abi, build_mode, False)

    do_build_apk(build_mode,android_platform)


# def main(cfgFile=None):
#     print("main")
#     startBuild("release","android-26","armeabi-v7a:arm64-v8a",True,True)

# if __name__ == "__main__":
#     utils.runMain(main)
