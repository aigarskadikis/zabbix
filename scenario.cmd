@echo off
set %path%;%~dp0
set o=%1
echo %o%
if not exist "%~dp0ccmcache" md "%~dp0ccmcache"
for /f "tokens=*" %%t in ('curl -s %o% ^| jq -r ".entry|.title|.\"$t\""') do set filename=%%t
echo downloading %filename%
curl -s %o% | jq -r ".entry|.content|.\"$t\"" > c:\zabbix\file.%filename%.base64 
echo decoding 
"%systemroot%\System32\certutil.exe" -decode "c:\zabbix\file.%filename%.base64" c:\zabbix\file.%filename%

