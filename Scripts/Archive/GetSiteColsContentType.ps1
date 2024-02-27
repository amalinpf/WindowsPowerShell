#Config Variables
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityClerkDepartment"
$ContentTypes =@("Agreement","Bids","Certificates Of Insurance","Clerk Budget Documents","Document","Elections Document","Finding","Policy Document","Proclamation")
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Get the site content type
foreach ($contentType in $contentTypes) {
	$CTID = Get-PnPContentType -Identity $ContentType
	 
	#Get Content Type ID
	write-host $CTID.Id.ToString(), $CTID.Name
}


<#
Get-PnPField
Get-PnPField | Select Title, TypeDisplayName, InternalName, id, group | Out-GridView
#>
