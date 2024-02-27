# $profile.CurrentUserAllHosts	(AMALINREMOTE-PC)

Set-Variable -Name HOME -Force -Value "h:\" 
Set-Location H:\Documents\WindowsPowerShell\Scripts

function prompt {"PS [" + $env:computername.tolower() + "]> "}

if(!(Test-Path alias:np)) { new-alias np "C:\Program Files (x86)\Notepad++\notepad++.exe" }

