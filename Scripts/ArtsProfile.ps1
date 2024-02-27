# H:\Documents\WindowsPowerShell\Scripts\ArtsProfile.ps1

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

#Set-Variable -Name HOME -Force -Value "$env:homedrive$env:homepath" 
Set-Variable -Name HOME -Force -Value "h:\" 
Set-Location "$home\Documents\WindowsPowerShell\Scripts"

function prompt {"PS [" + $env:computername.tolower() + "]> "}

if(!(Test-Path alias:np)) { new-alias np "C:\Program Files (x86)\Notepad++\notepad++.exe" }

$PROFILE | Get-Member -Type NoteProperty
write-output ""
write-output "Current Profile: $PROFILE"
