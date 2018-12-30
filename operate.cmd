@echo off

rem allow to use grep, zabbix_sender from current dir
set path=%path%;%~dp0

rem import %Server% variable, so zabbix_sender know what to contact
call "%~dp0contact.cmd"

rem create variables
call "%~dp0create-vars.cmd" %1 %2 %3 %4

if not exist "%~dp0ccmcache\%destination%" md "%~dp0ccmcache\%destination%"

rem to successfully work with !errorlevel!
setlocal EnableDelayedExpansion

if not exist "%~dp0ccmcache\%destination%\%filename%" (
echo %filename% do not exist. will download it now
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 2 > nul 2>&1
curl %l% > "%~dp0ccmcache\%destination%\%filename%"
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 3 > nul 2>&1
)

rem if filename exists then check sha1 sum
if exist "%~dp0ccmcache\%destination%\%filename%" (
sha1sum "%~dp0ccmcache\%destination%\%filename%" | sed "s/ .*$//g" | grep %sha1sum%
if !errorlevel!==0 (

echo checksum match. will check if some other apps are installing
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 4 > nul 2>&1
rem 4 - setup file exists, sha1 correct

tasklist | grep "msiexec.exe" > nul 2>&1
if not !errorlevel!==0 (
echo are ready to receive new installs

rem check if reboot is pending
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" > nul 2>&1
if not !errorlevel!==0 (
echo ready to install

call "%~dp0%5.cmd" %k% "%~dp0ccmcache\%destination%\%filename%"

) else zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 7 > nul 2>&1
rem 7 - reboot are required to continue

) else zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 6 > nul 2>&1
rem 6 - msiexec already running

) else zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o 1 > nul 2>&1
rem 1 - sha1 checksum do not match

)

endlocal

