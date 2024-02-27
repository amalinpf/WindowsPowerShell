#Parameters
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept"
$ListName = "Helpful SP URLs"
$ColumnName = "Link" #Internal Name of the Field
$OldString = "https://postfallsidahoorg.sharepoint.com/sites/cityhallitdept" #Set it in lower case
$NewString = ""
 
#Connect to SharePoint Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Get All List Items
$ListItems = Get-PnPListItem -List $ListName -PageSize 2000
 
#Iterate through all items in the list
ForEach ($Item in $ListItems)
{
    $Flag =  $false
    $URL = $Item.FieldValues[$ColumnName].URL.ToLower()
 
<#     #Check if the URL has the old text
    If($URL.contains($OldString))
    {
        $URL = $URL -Replace $OldString,$NewString
        $Flag =  $True
    }
 #> 
    #check the description of the Hyperlink
    $Description = $Item.FieldValues[$ColumnName].Description.ToLower()
    If($Description.contains($OldString))
    {
        $Description = $Description -Replace $OldString,$NewString
        $Flag =  $True
    }
Write-output "URL: "$URL"    Description: "$Description
    
    #update the Hyperlink field if URL or Description has the old string
    If($Flag -eq $True)
 {
        #Frame the URL field value
        $Hyperlink = New-Object Microsoft.SharePoint.Client.FieldUrlValue
        $Hyperlink.Url= $URL
        $Hyperlink.Description= $Description
 
        #Update Hyperlink field value
        Set-PnPListItem -List $ListName -Identity $Item.Id -Values @{$ColumnName = [Microsoft.SharePoint.Client.FieldUrlValue]$Hyperlink} | Out-Null
        Write-host -f Green "List Item $($Item.ID) Updated!"
    }

 
 }
