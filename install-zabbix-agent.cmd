@echo off
setlocal EnableDelayedExpansion

sc query "Zabbix Agent" > nul 2>&1
if not !errorlevel!==0 (
"%~dp0zabbix_agentd.exe" --config "%~dp0zabbix_agentd.conf" --install
sc start "Zabbix Agent"
) else echo Zabbix Agent already exist

endlocal
