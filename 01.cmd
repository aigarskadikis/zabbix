@echo off

rem allow to use grep, zabbix_sender from current dir
set path=%path%;%~dp0

rem import %Server% variable, so zabbix_sender know what to contact
call "%~dp0contact.cmd"

rem create variables
call "%~dp0create-vars.cmd" %1 %2 %3 %4

if not exist "%~dp0ccmcache\%destination%" md "%~dp0ccmcache\%destination%"

echo %filename%

setlocal EnableDelayedExpansion

rem zabbix_sender -z %Server% -s "%computername%" -k active.presenter.status -o 0


endlocal

