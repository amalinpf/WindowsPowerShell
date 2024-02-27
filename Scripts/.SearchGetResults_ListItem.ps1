$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com/'

$searchTerms = 'SearchTerms'
$FileNameScrubbed = $searchTerms.replace('"', "'")
$ExcelFile = "C:\Temp\Legal\CSVlist\SearchResults_List($FileNameScrubbed).xlsx"
$StartRow = 0

Connect-PnPOnline -url $AdminSiteURL  -Interactive

$itemsToSave = @()

$query = $searchTerms + ' LastModifiedTime>=2019-01-01 
-ContentClass:(STS_ListItem_DocumentLibrary OR STS_ListItem_MySiteDocumentLibrary)
-Path:"https://postfallsidahoorg.sharepoint.com/sites/LegalDepartment"
-FileName:"MiscXferNotes.xlsx"'

$properties = 'Title,FileName,Site,Path,LastModifiedTime,ContentClass'
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
$itemsToSave | Export-Excel -Path $ExcelFile
