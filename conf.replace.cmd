@echo off
setlocal EnableDelayedExpansion

rem meaning of result codes
rem 0 - we recieved argument 0 which means 'do not do anything'
rem 1 - replacement procedure was executed
rem 2 - zabbix_agentd.conf.latest file do not exist
rem 3 - unknown argument
rem 4 - no parameter was given to program

if "%1"=="0" (
echo 0
exit /b 0
)

rem if no parameter is given to this program the exit end return status code 4
if "%1" == "" (
echo 4
exit /b 4
)

rem do the replacement
if "%1"=="1"  (

if exist "%~dp0zabbix_agentd.conf.latest" (

xcopy /Y /Q "%~dp0zabbix_agentd.conf.latest" "%~dp0zabbix_agentd.conf" > nul 2>&1
del "%~dp0zabbix_agentd.conf.latest" > nul 2>&1
echo 1

) else echo 2

) else echo 3

endlocal
