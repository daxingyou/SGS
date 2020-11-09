@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname Galaxy_S9_2960x1440 -resolution 1644x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
