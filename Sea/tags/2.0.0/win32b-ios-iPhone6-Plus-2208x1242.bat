@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPhone6_Plus_2208x1242 -resolution 1422x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
