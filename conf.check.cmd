@echo off
setlocal EnableDelayedExpansion

rem meening of result codes
rem 0 - sha1sum already match zabbix_agentd.conf. no need to do anything
rem 1 - zabbix_agentd.conf.latest file is ready to initiate the original. We are waiting for the UserParameter conf.agentd.replace.with.latest[*] to replace the file current file
rem 2 - the file online do not match with the checksum provided. This is serious error. Need to fix as soon as possible.
rem 3 - the downloaded file now match the checksumm provided. The zabbix_agentd.conf.latest are ready to take the place of zabbix_agentd.conf. Waiting for {$REPLACE_AGENTD_CONF}=1 setting in host level
rem 4 - no parameter was given to program

rem if no parameter is given to this program the exit end return status code 1
if "%1" == "" (
echo 4
exit /b 4
)
rem check if active config match the checksum
sha1sum "c:\zabbix\zabbix_agentd.conf" | grep "%1" > nul 2>&1

rem if do not match the checksum then..
if not !errorlevel!==0 (

rem check if there is already downloaded file which match the checksum
if exist "c:\zabbix\zabbix_agentd.conf.latest" (

rem make checksum
sha1sum "c:\zabbix\zabbix_agentd.conf.latest" | grep "%1" > nul 2>&1

rem if checksum match then 'echo 1' and exit programm
if !errorlevel!==0 (
echo 1
exit /b 0
)

rem if the checksum did not match then delete the file
del "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1
)

rem if there is a need to download latest file which are suposed to match the checksumm
if not exist "c:\zabbix\zabbix_agentd.conf.latest" (
rem download file
curl -s "https://raw.githubusercontent.com/catonrug/zabbix/master/zabbix_agentd.conf" > "c:\zabbix\zabbix_agentd.conf.latest"

rem check if the file online match the checksum
sha1sum "c:\zabbix\zabbix_agentd.conf.latest" | grep "%1" > nul 2>&1
if not !errorlevel!==0 (
del "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1
echo 2
exit /b 2
) else echo 3

)


) else echo 0

endlocal
