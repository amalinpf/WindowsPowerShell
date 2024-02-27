$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept/"
$ListName = "Cheat Sheets"
$NewListURL = "CheatSheets"
  
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Get the List
$List= Get-PnPList -Identity $ListName -Includes RootFolder | select *
 
#sharepoint online powershell change list url
$List.Rootfolder.MoveTo($NewListURL)
Invoke-PnPQuery
