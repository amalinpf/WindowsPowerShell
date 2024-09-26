Return  # Don't execute accidentally

# List all site collections

$TenantURL = "https://postfallsidahoorg-admin.sharepoint.com" 
$OutFile = ".\Output\SiteCollections.csv"
$InFile = ".\Input\Site_Collections - All.csv"      # or .txt

########  Get ALL site collections 
	Connect-PnPOnline -Url $TenantURL -Interactive

		#------------  List all on screen
			Get-PnPTenantSite  # Lists them all on screen

		#------------  OR export to csv excluding non-applicable templates
			Get-PnPTenantSite | Where -Property Template -NotIn ("SRCHCEN#0", "REDIRECTSITE#0", "SPSMSITEHOST#0", "APPCATALOG#0", "POINTPUBLISHINGHUB#0", "EDISC#0", "STS#-1","TEAMCHANNEL#1")  | select url | Export-Csv -path $OutFile -NoTypeInformation

########  Get site collections FROM FILE
	$sc = Import-Csv $InFile 

########  Get SITES from Site Collections
	foreach($site in $sc)
		{
		write-Host $site.full_url
		Connect-PnPOnline -Url $site.full_url -Interactive
		# SITE commands...
		
	########  Get LISTS from Sites
		$lists = Get-PnPList -Includes Fields
		foreach($list in $lists)
		{
			write-host $list
			if (-Not ($list.Hidden)) 
			{
			########  Get FIELDS from Lists
				$list.Fields | select scope,title,internalname,typeasstring | export-csv -NoTypeInformation $OutFile -Append
				# or other fieldy stuff...
			}	# Fields
		}	# Lists
	}	#  Sites
