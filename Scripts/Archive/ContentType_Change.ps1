$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityClerkDepartment"
$ListName = "Policies"
$OldContentTypeName = "Nothing"
$NewContentTypeName = "Policy Document"
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Get the New Content Type from the List
$NewContentType = Get-PnPContentType -List $ListName | Where {$_.Name -eq $NewContentTypeName}
#Get List Items of Old content Type
$ListItems = Get-PnPListItem -List $ListName -Query "<View><Query><Where><Eq><FieldRef Name='ContentType'/><Value Type='Computed'>$OldContentTypeName</Value></Eq></Where></Query></View>"
Write-host "Total Number of Items with Old Content Type:"$ListItems.count
ForEach($Item in $ListItems)
{
    Set-PnPListItem -List $ListName -Identity $Item -ContentType $NewContentType
}

