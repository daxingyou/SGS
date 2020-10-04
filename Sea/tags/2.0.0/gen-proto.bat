@echo off

set dir=%~dp0
cd %dir%
python %dir%gen-proto.py
exit