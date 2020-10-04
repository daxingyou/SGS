@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname xiaomi_Mix2_2160x1080 -resolution 1600x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
