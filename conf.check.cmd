@echo off
setlocal EnableDelayedExpansion

rem if no parameter is given to this program the exit end return status code 1
if "%1" == "" exit /b 1

rem check if active config match the checksum
sha1sum "c:\zabbix\zabbix_agentd.conf" | grep "%1" > nul 2>&1

rem if do not match the checksum then..
if not !errorlevel!==0 (

rem check if there is already downloaded file which match the checksum
if exist "c:\zabbix\zabbix_agentd.conf.latest" (

rem make checksum
sha1sum "c:\zabbix\zabbix_agentd.conf.latest" | grep "%1" > nul 2>&1

rem if checksum do not match..
if not !errorlevel!==0 (
rem delete file
del "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1
rem try to download file which is online. lets hope the checksum will match for that file
curl -s "https://raw.githubusercontent.com/catonrug/zabbix/master/zabbix_agentd.conf" > "c:\zabbix\zabbix_agentd.conf.latest"
)

rem last check
sha1sum "c:\zabbix\zabbix_agentd.conf.latest" | grep "%1" > nul 2>&1
if !errorlevel!==0 (
del "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1
echo 103
)

if exist "c:\zabbix\zabbix_agentd.conf.latest" (
ls -s c:\zabbix\zabbix_agentd.conf.latest | sed "s/ .*$//g"
) else echo 101

) rem zabbix_agentd.conf.latest not exist

) else echo 0

endlocal
