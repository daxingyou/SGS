@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname OPPO_R15_2280x1080 -resolution 1688x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
