<# SharePoint Online: Change Content Type of List Items using PowerShell
https://www.sharepointdiary.com/2018/02/sharepoint-online-change-content-type-using-powershell.html
#>

#Set Variables

$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CDWirelessProject"
$ListName = "Wireless Project Documents"
$OldContentTypeName = "Wireless Project OLD" 
$NewContentTypeName = "CommDev Documents"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
$List =  Get-PnPList -Identity $ListName
 
#Get the Old and New Content Types from the List
$OldContentType = Get-PnPContentType -List $ListName | Where {$_.Name -eq $OldContentTypeName}
$NewContentType = Get-PnPContentType -List $ListName | Where {$_.Name -eq $NewContentTypeName}
 
#Get List Items of old content type from the list
$global:counter = 0;
$ListItems = Get-PnPListItem -List $List -PageSize 500 -Fields ContentTypeId -ScriptBlock { Param($items) $global:counter += $items.Count; Write-Progress -PercentComplete `
              ($global:Counter / ($List.ItemCount) * 100) -Activity "Getting Items from List" -Status "Checking Items $global:Counter to $($List.ItemCount)"} | Where {$_.FieldValues.ContentTypeId.ToString() -eq $OldContentType.StringId}
 
Write-host "Total Number of Items with Old Content Type Found:"$ListItems.count
#Loop through List Items
ForEach($Item in $ListItems)
{
    #Change the Content Type of the List Item
    Set-PnPListItem -List $ListName -Identity $Item -ContentType $NewContentType -Force | Out-Null
    Write-host "Content Type Updated for List Item ID $($Item.ID)!" -f Green
}
