@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -model "iPhone11,4" -viewname iPhoneXS_Max_2688x1242 -resolution 1732x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
