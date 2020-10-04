@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname android_2.65_1184x720 -resolution 1184x720 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
