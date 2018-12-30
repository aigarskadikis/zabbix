rem parse arguments
rem parse arguments set:
rem "%n%" = applications name
rem "%k%" = uninstall key
rem "%l%" = url (link) to get the app
rem "%h%" = hash, checksum of file

set n=%1
set k=%2
set l=%3
set h=%4
set sw=HKLM\SOFTWARE
set u=Microsoft\Windows\CurrentVersion\Uninstall


rem remove double quotes (first and last character) from name
for /f "tokens=*" %%n in ('^
echo %n%^|
sed "s/.$//;s/^.//"') do set name=%%n

for /f "tokens=*" %%h in ('^
echo %h%^|
sed "s/.$//;s/^.//"') do set sha1sum=%%h


rem prepare destination dir dir
for /f "tokens=*" %%d in ('^
echo %l%^|
sed "s/^.*\/\///g;s/\//\\/g" ^|
sed "s/.$//" ^|
sed "s/\\[0-9a-zA-Z_. ]\+$//"') do set destination=%%d

rem filename
for /f "tokens=*" %%f in ('^
echo %l%^|
sed "s/.$//" ^|
sed "s/^.*\///g"') do set filename=%%f

