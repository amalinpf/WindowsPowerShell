#Do from WORKSTATION
$WebURL = "https://postfallsidahoorg.sharepoint.com/sites/"
$site = 'CityClerkDepartment'       #use '' to get them all
$OutFile = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell\Output\$($site)_Recycle_Bin.csv"

Connect-PnPOnline -Url $WebURL$site -Interactive
Get-PnPRecycleBinItem | Select Id, DirName, Title, Size, DeletedDate, ItemType, ItemState, DeletedByName | export-csv $OutFile

<#
#Restore
Restore-PnpRecycleBinItem -Identity d02bfd8b-26e0-476a-946b-dcf8b52eddae -Force

#Permanently delete
Clear-PnpRecycleBinItem -Identity 7a5d5574-1754-42b0-9777-eec31d919c8c
#>