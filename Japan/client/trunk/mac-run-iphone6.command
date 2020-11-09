#!/bin/sh

filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath
cd $filepath
open ./runtime/mac/xgame-desktop.app --args -resolution 2208x1242 -scale 0.7 -workdir ${filepath}/cocosstudio -writable-path ${filepath}/documents -write-debug-log ${filepath}/documents/log.txt -console enable
exit 0