@echo off

set dir=%~dp0
cd %dir%tools/external/
curl.exe -i "http://10.235.102.213:8080/jenkins/job/build_xgame2_develop_win32/buildWithParameters?token=xgame456&PC=2.7.0"
pause