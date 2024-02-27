$searchTerms = '"Falls City Development" AND (Entitlements OR Dedications)'
$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com/'
$FileNameScrubbed = $searchTerms.replace('"', "'")
#$ExcelFile = "C:\Temp\Legal\CSV\SearchResults($FileNameScrubbed).xlsx"
$ExcelFile = "C:\Temp\Legal\CSV\SearchResults($FileNameScrubbed).csv"
$StartRow = 0
$itemsToSave = @()
$query = $searchTerms + ' LastModifiedTime>=2019-01-01 
IsDocument:True
-path:https://postfallsidahoorg.sharepoint.com/sites/LegalDepartment/*  
-path:https://postfallsidahoorg-my.sharepoint.com/personal/amalin_postfalls_gov 
-filename:MiscXferNotes.xlsx 
'

$properties = 'Title,FileName,Site,Path,LastModifiedTime,ContentClass'

Connect-PnPOnline -url $AdminSiteURL  -Interactive
$search = Submit-PnPSearchQuery -Query $query -StartRow $StartRow -SortList @{LastModifiedTime = 'descending' }  -SelectProperties $properties -TrimDuplicates $true

foreach ($row in $search.ResultRows) {
	$data = [PSCustomObject]@{
		"Title"        = $row["Title"]
		"FileName"     = $row["FileName"]
		"Site"         = $row["SPWebUrl"]
		"Path"         = $row["Path"].replace(' ', "%20")   #Convert to clickable link
		"Search"       = $searchTerms
		"Modified"     = $row["LastModifiedTime"]
		"ContentClass" = $row["ContentClass"]
	}
	$itemsToSave += $data
}
Write-host $itemsToSave.count "items saved to " $ExcelFile
#$itemsToSave | Export-Excel -Path $ExcelFile
$itemsToSave | Export-csv -Path $ExcelFile

# Disconnect-PnPOnline
