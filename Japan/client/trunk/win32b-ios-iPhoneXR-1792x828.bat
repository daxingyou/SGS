@echo off

set dir=%~dp0
cd %dir%runtime/win32/
start xgame.exe -model "iPhone11,8" -viewname iPhoneXR_1792x828 -resolution 1732x800 -scale 0.7 -workdir %dir%cocosstudio -writable-path %dir%documents -write-debug-log %dir%documents/log.txt -console enable
exit
