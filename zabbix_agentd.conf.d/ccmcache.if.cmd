@echo off
set path=%path%;%~dp0
set z=c:\zabbix
set c=%z%\ccmcache

if exist "%c%" (
rem report directory count
dir /b "%c%" | find /v /c ""

rem list blog IDs
for /f "tokens=*" %%l in ('dir /b "%c%"') do (

rem list post IDs
for /f "tokens=*" %%b in ('dir /b "%c%\%%l"') do (

rem check if source has been already prepared
if not exist "%c%\%%l\%%b\offline.ready" (

rem if source in not ready then shedule to prepare it IN BACKGROUND and EXIT PROGRAM
for /f "tokens=*" %%p in ('dir /b "%c%\%%l\%%b\*.cmd"') do (
rem start "" "%c%\%%l\%%b\%%p" prepare
start "" "%c%\%%l\%%b\%%p" prepare
)

)
)
)
)


