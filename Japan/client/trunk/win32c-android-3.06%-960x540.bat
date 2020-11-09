@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname android_3.06_960x540 -resolution 960x540 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
