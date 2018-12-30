@echo off

rem allow to use grep, zabbix_sender from current dir
set path=%path%;%~dp0

rem import %Server% variable, so zabbix_sender know what to contact
call "%~dp0contact.cmd"

rem create variables
call "%~dp0create-vars.cmd" %1 %2 %3 %4

if not exist "%~dp0ccmcache\%destination%" md "%~dp0ccmcache\%destination%"


setlocal EnableDelayedExpansion

if not exist "%~dp0ccmcache\%destination%\%filename%" (
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 2
curl %l% > "%~dp0ccmcache\%destination%\%filename%"
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 3
) else echo %filename% do not exist. will download it now

if exist "%~dp0ccmcache\%destination%\%filename%" (
sha1sum "%~dp0ccmcache\%destination%\%filename%" | sed "s/ .*$//g" | grep %sha1sum%
if !errorlevel!==0 (
echo checksum match
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 4


) else zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 1
)



endlocal

