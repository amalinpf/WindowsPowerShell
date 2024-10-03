# https://www.sharepointdiary.com/2016/06/sharepoint-online-add-content-type-to-list-library-using-powershell.html
#Config Variables
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CommunityDevelopment"
$ContentTypeName="PUD"
$ListName="Documents"
 
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive -ClientID $ClientID
     
#Get the content type
$ContentType = Get-PnPContentType -Identity $ContentTypeName
 
If($ContentType)
{
    #Add Content Type to Library
    Add-PnPContentTypeToList -List $ListName -ContentType $ContentType
}
else
{
    Write-host -f Yellow "Could Not Find Content Type:"$ContentTypeName
}

