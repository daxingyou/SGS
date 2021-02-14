@echo off

set dir=%~dp0
cd %dir%tools/external/Python27/
python.exe %dir%tools/script/switch.py
pause