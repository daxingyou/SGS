@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPad_Pro10.5_2244x1668 -resolution 1076x800 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
