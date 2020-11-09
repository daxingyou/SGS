@echo off

set dir=%~dp0
cd %dir%
python %dir%gen-csb.py
exit