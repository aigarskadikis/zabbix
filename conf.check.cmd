@echo off
setlocal EnableDelayedExpansion

if "%1" == "" exit /b 1

sha1sum "c:\zabbix\zabbix_agentd.conf" | grep "%1" > nul 2>&1

if not !errorlevel!==0 (

curl -s "https://raw.githubusercontent.com/catonrug/zabbix/master/zabbix_agentd.conf" > "c:\zabbix\zabbix_agentd.conf.latest"

if exist "c:\zabbix\zabbix_agentd.conf.latest" (

sha1sum "c:\zabbix\zabbix_agentd.conf.latest" | grep "%1" > nul 2>&1
if not !errorlevel!==0 del "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1

if exist "c:\zabbix\zabbix_agentd.conf.latest" (
ls -s c:\zabbix\zabbix_agentd.conf.latest | sed "s/ .*$//g"
) else echo 101

) else echo 102

) else echo 0

endlocal
