$InFile = ".\Input\Site_Collections_All.csv"      # or .txt
$OutFile = ".\Output\SiteGroups.csv"       # or .txt

# CSV FILE WITH ONE VALUE PER LINE, column names in first row:
Import-Csv $InFile | ForEach-Object {
	$SiteURL = "$($_.Full_URL)"
	Write-Output $SiteURL
	$SiteURL | Out-File $OutFile -Append

	Connect-PnPOnline -Url $SiteURL -Interactive
	 
	#Get All Groups from the site - Exclude Hidden, Limited Access and SharingLinks Groups
	Get-PnPGroup | Where {$_.Title -Like "*Hub Visitors"} | Out-File $OutFile -Append
}
