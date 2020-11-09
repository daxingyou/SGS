@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPad_Pro12.9_2732x2048 -resolution 1067x800 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
