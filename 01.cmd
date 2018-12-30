@echo off
set path=%path%;%~dp0
setlocal EnableDelayedExpansion

rem get zabbix the IP address of zabbix proxy/server
for /f "tokens=*" %%s in ('^
grep "^Server=" "%~dp0zabbix_agentd.conf.d\Server.conf" ^|
grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" ^|
grep -v "127.0.0.1"') do (

echo IP address of zabbix proxy/server = %%s

zabbix_sender -z %%s -s "%computername%" -k active.presenter.status -o 2



)



endlocal
