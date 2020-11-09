@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname android_4.64_1812x1080 -resolution 1342x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
