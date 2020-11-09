@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPhone5_1136x640 -resolution 1136x640 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
