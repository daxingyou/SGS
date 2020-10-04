@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname HUAWEI_P20_Pro_2240x1080 -resolution 1659x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
