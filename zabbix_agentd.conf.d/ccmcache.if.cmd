@echo off
set path=%path%;%~dp0
set z=c:\zabbix
set c=%z%\ccmcache

if exist "%c%" (
rem report directory cound
dir /b "%c%" | find /v /c ""

for /f "tokens=*" %%l in ('dir /b "%c%"') do (
echo %%l

for /f "tokens=*" %%b in ('dir /b "%c%\%%l"') do (

if not exist "%c%\%%l\%%b\offline.ready" (

for /f "tokens=*" %%p in ('dir /b "%c%\%%l\%%b\*.cmd"') do (
echo %%p
)

)
)
)
)


