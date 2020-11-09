@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -viewname iPhone6_1334x750 -resolution 1334x750 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
