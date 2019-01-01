@echo off
set path=%path%;%~dp0
set o=%1
echo %o%

for /f "tokens=*" %%l in ('curl -s %o% ^|
jq -r ".entry|.id|.\"$t\"" ^|
sed "s/^.*blog.//;s/.post./\\/"') do set d=%~dp0ccmcache\%%l
if not exist "%d%" md "%d%"

for /f "tokens=*" %%t in ('curl -s %o% ^| jq -r ".entry|.title|.\"$t\""') do set filename=%%t
echo downloading %filename%
curl -s %o% | jq -r ".entry|.content|.\"$t\"" > "%d%\%filename%.base64"
echo decoding
if exist "%d%\%filename%" del "%d%\%filename%"
"%systemroot%\System32\certutil.exe" -decode "%d%\%filename%.base64" "%d%\%filename%"
