@echo off

echo {"data":[
echo {"{#NAME}":%1},
echo {"{#UKEY}":%2},
echo {"{#URL}":%3},
echo {"{#CHECHSUM}":%4},
echo {"{#METHOD}":%5}
echo ]}

rem test
rem app2maintain.cmd "ActivePresenter" "ActivePresenter" "https://cdn.atomisystems.com/apdownloads/ActivePresenter_v7.5.2_setup.exe" "92d4ecd25f821df9dfb32c1140446421decf5bac" "01"
