@echo off
rem windows user discover
if exist "c:\users" set dir=c:\users
if not exist "c:\users" set dir=c:\documents and settings
echo {"data":[
for /F "tokens=*" %%a in ('dir /b "%dir%"') do echo {"{#USERNAME}":"%%a"},
echo {"{#USERNAME}":"XqMzJztwPV6hybmfteJj"}]}