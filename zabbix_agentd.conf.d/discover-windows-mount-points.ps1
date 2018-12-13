# this PowerShell script will generate JSON object which is compatible from Zabbix LLD rile
# to master anotger Get-WmiObject always start with
# Get-WmiObject <object-name>
# and filter out only the necessary properties. This will speed up the execution.
# pipe with where-object is optional
$colItems = Get-WmiObject Win32_Volume -Property DeviceID,Name,Label,FreeSpace,Capacity,__CLASS,SerialNumber | Where-Object { ($_.__CLASS -eq 'Win32_Volume') }
$i = 0
# Output the JSON header
Write-Host "{"
Write-Host " `"data`":["
Write-Host
foreach ($objItem in $colItems) {
  $i++
  if ($i -lt $colItems.Count) {
    $line = " { `"{#DEVICEID}`":`"" + ($objItem.DeviceID -replace "\\","\\") + "`" , `"{#NAME}`":`"" + ($objItem.Name -replace "\\","\\") + "`" , `"{#SERIAL}`":`"" + $objItem.SerialNumber + "`" , `"{#LABEL}`":`"" + $objItem.Label + "`" , `"{#CAPACITY}`":`"" + $objItem.Capacity + "`" },"
    Write-Host $line
  }
  else {
    $line = " { `"{#DEVICEID}`":`"" + ($objItem.DeviceID -replace "\\","\\") + "`" , `"{#NAME}`":`"" + ($objItem.Name -replace "\\","\\") + "`" , `"{#SERIAL}`":`"" + $objItem.SerialNumber + "`" , `"{#LABEL}`":`"" + $objItem.Label + "`" , `"{#CAPACITY}`":`"" + $objItem.Capacity + "`" }"
    Write-Host $line
  }
}
# Close the JSON message
Write-Host
Write-Host " ]"
Write-Host "}"
Write-Host
# check if JSON result is OK via https://jsonlint.com/
# todo: truncate the trailing white space while outputing "{#LABEL}":"SYSTEM "
