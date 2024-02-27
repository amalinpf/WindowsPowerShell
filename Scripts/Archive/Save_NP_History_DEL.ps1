 
#Save Notepad++ History to 'Documents'

$XMLsource = "$($env:APPDATA)\Notepad++\config.xml"
$OutputPath = "\\triumph\homes$\amalin\Documents\NPHistory"

#Create Output file
"Notepad++ History list for: $(hostname)  $(Date)"  | Out-File "$($OutputPath)_$(hostname).txt" 

[xml]$XmlDocument = Get-Content $XMLsource
$XmlDocument.NotepadPlus.History.File | Out-File -append "$($OutputPath)_$(hostname).txt" 
