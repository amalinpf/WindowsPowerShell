$searchTerms = 'CBS'
$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com/'
$FileNameScrubbed = $searchTerms.replace('"', "'")
$ExcelFile = "C:\Temp\Legal\CSV\SearchResults($FileNameScrubbed).csv"
$StartRow = 0
$itemsToSave = @()
$query = "$searchTerms `
	LastModifiedTime>=2019-01-01 `
	IsDocument:True `
	-filename:MiscXferNotes.xlsx `
	-path:(https://postfallsidahoorg.sharepoint.com/sites/LegalDepartment/ OR `
		  https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept/ OR `
		  https://postfallsidahoorg.sharepoint.com/sites/GeneralTesting)"
		  
$properties = 'Title,FileName,Site,Path,LastModifiedTime,ContentClass,ContentType'

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
		"ContentClass" = $row["contentclass"]
		"ContentType"  = $row["contentclass"]
	}
	$itemsToSave += $data
}
Write-host $itemsToSave.count "items saved to " $ExcelFile
$itemsToSave | Export-Csv -Path $ExcelFile -NoTypeInformation

# Disconnect-PnPOnline
