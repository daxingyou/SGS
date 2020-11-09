#!/bin/sh

filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath
cd $filepath
open ./runtime/mac/xgame-desktop.app --args -resolution 1024x768 -workdir ${filepath}/cocosstudio -writable-path ${filepath}/documents -write-debug-log ${filepath}/documents/log.txt -console enable
exit 0