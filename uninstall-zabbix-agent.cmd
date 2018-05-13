@echo off
setlocal EnableDelayedExpansion

sc query "Zabbix Agent" > nul 2>&1
if !errorlevel!==0 (
sc stop "Zabbix Agent"
sc delete "Zabbix Agent"
) else echo Zabbix Agent not installed

endlocal
pause
