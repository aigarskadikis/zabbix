@echo off
setlocal EnableDelayedExpansion

if not "%1" == "" (

sha1sum "c:\zabbix\zabbix_agentd.conf" | grep "%1" > nul 2>&1

if not !errorlevel!==0 (
curl -s "https://catonrug.blogspot.com/feeds/posts/default/6828580331777948799?alt=json" | sed "s/{\|.}/\n/g" | grep ":.html.," | sed "s/^.*\d034//g;s/\\\\//g" > "c:\zabbix\zabbix_agentd.conf.latest.base64"

if exist "c:\zabbix\zabbix_agentd.conf.latest.base64" (
start /wait "" "%systemroot%\System32\certutil.exe" -decode "c:\zabbix\zabbix_agentd.conf.latest.base64" "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1

sha1sum "c:\zabbix\zabbix_agentd.conf.latest" | grep "%1" > nul 2>&1
if not !errorlevel!==0 del "c:\zabbix\zabbix_agentd.conf.latest" > nul 2>&1

if exist "c:\zabbix\zabbix_agentd.conf.latest" (
ls -s c:\zabbix\zabbix_agentd.conf.latest | sed "s/ .*$//g"
) else echo 0

) else echo 0

) else echo 0

) else echo 0

if exist "c:\zabbix\zabbix_agentd.conf.latest.base64" del "c:\zabbix\zabbix_agentd.conf.latest.base64" > nul 2>&1

endlocal
