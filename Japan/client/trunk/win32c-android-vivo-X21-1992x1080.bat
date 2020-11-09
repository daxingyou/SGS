@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname vivo_X21_1992x1080 -resolution 1476x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
