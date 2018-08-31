@echo off
echo.
rem place this file in the same directory where [zabbix_get.exe] is located
rem make sure [Server=] also points to 127.0.0.1. This will allow to poll (test) metrics from local machine

setlocal EnableDelayedExpansion

set file=available-metrics.log
set nonzero=non-zero-metrics.log
set item4zabbix=item-key-in-zabbix.log
echo placing all counters in file "%~dp0%file%". this will take some time..
typeperf -qx > "%~dp0%file%"
rem clear the files
type "" > "%~dp0%nonzero%"
type "" > "%~dp0%item4zabbix%"
echo.
for /f "tokens=*" %%m in ('type "%~dp0%file%" ^| findstr "Skype"') do (
"%~dp0zabbix_get.exe" -s 127.0.0.1 -k "perf_counter[\"%%m\",30]" | findstr "0.000000" > nul 2>&1
if not !errorlevel!==0 (
echo %%m
"%~dp0zabbix_get.exe" -s 127.0.0.1 -k "perf_counter[\"%%m\",30]"
echo %%m >> "%~dp0%nonzero%"
echo perf_counter["%%m",30]>> "%~dp0%item4zabbix%"
)
)
endlocal
