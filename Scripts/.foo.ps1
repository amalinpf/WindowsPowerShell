$WebURL = "https://postfallsidahoorg.sharepoint.com/sites/"
$site = 'FinanceDepartment'       #use '' to get them all
$OutFile = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell\Output\$($site)_Recycle_Bin.csv"

Connect-PnPOnline -Url $WebURL$site -Interactive
Get-PnPRecycleBinItem | Select Id, DirName, Title, Size, DeletedDate, ItemType, ItemState, DeletedByName | export-csv $OutFile

Get-ADUser -filter * -properties samaccountname, userprincipalname | out-gridview 
