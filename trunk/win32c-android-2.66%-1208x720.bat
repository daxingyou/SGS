@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname android_2.66_1208x720 -resolution 1208x720 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
