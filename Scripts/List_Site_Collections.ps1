# List all site collections

$TenantURL = "https://postfallsidahoorg-admin.sharepoint.com" 
$OutFile = ".\Output\SiteCollections.csv"
 
######## Site collections ############################################ Get All Site collections 
Connect-PnPOnline -Url $TenantURL -Interactive
Get-PnPTenantSite  # Lists them all on screen

# Or export to csv excluding non-applicable templates
Get-PnPTenantSite | Where -Property Template -NotIn ("SRCHCEN#0", "REDIRECTSITE#0", "SPSMSITEHOST#0", "APPCATALOG#0", "POINTPUBLISHINGHUB#0", "EDISC#0", "STS#-1","TEAMCHANNEL#1")  | select url | Export-Csv -path $OutFile -NoTypeInformation


######## Test for NITRO installed #################
$SiteCollections = Get-PnPTenantSite | Where -Property Template -NotIn ("SRCHCEN#0", "REDIRECTSITE#0", "SPSMSITEHOST#0", "APPCATALOG#0", "POINTPUBLISHINGHUB#0", "EDISC#0", "STS#-1","TEAMCHANNEL#1")

ForEach($SC in $SiteCollections)	# Loop through each site collection
{
	If ( <<<TEST FOR NITRO, maybe look for a NITRO list?>>> )
	{
		Write-host $SC.URL
	}
}