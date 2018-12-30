
:detectx86
if "%ProgramFiles(x86)%"=="" goto x86

:x64only
reg query "%sw%\Wow6432Node\%u%" /s | find %1
if !errorlevel!==0 goto exist

:x86
reg query "%sw%\%u%" /s | find %1
if !errorlevel!==0 goto exist

echo %1
start /wait "" "%2" /SILENT
zabbix_sender -z %Server% -s "%computername%" -k status.of[%name%] -o !errorlevel! > nul 2>&1

:exist
