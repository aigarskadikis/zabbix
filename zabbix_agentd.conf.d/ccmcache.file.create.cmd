@echo off
set path=%path%;%~dp0
set z=c:\zabbix
set o=%1
rem echo %o%

for /f "tokens=*" %%l in ('curl -s %o% ^|
jq -r ".entry|.id|.\"$t\"" ^|
sed "s/^.*blog.//" ^|
sed "s/.post./\\\\/"') do set d=%z%\ccmcache\%%l
rem echo "%d%"
if not exist "%d%" md "%d%"

for /f "tokens=*" %%t in ('curl -s %o% ^| jq -r ".entry|.title|.\"$t\""') do set filename=%%t
rem echo downloading %filename%
curl -s %o% | jq -r ".entry|.content|.\"$t\"" > "%d%\%filename%.base64"
rem echo decoding
if exist "%d%\%filename%" del "%d%\%filename%"
"%systemroot%\System32\certutil.exe" -decode "%d%\%filename%.base64" "%d%\%filename%" > nul 2>&1
echo 1