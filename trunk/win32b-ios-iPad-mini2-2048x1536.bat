@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPad_mini2_2048x1536 -resolution 1066x800 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
