@echo off
rem windows user discover
echo {"data":[
for /F "tokens=*" %%a in ('dir /b "%1"') do echo {"{#USERNAME}":"%%a"},
echo {"{#USERNAME}":"XqMzJztwPV6hybmfteJj"}]}