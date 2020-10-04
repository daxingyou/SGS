@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPhone4_960x640 -resolution 960x640 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
