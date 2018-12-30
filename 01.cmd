@echo off

rem allow to use grep, zabbix_sender from current dir
set path=%path%;%~dp0

rem import %Server% variable, so zabbix_sender know what to contact
call "%~dp0contact.cmd"

setlocal EnableDelayedExpansion

zabbix_sender -z %Server% -s "%computername%" -k active.presenter.status -o 0


endlocal
