@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPad_mini_1024x768 -resolution 1024x768 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
