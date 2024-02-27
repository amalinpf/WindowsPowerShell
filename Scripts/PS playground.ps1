
$OutFile = ".\Output\SearchResults.csv"   

$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-PnPOnline -url $AdminSiteURL  -interactive

$itemsToSave = @()

$query = "{Jerod Harwood} LastModifiedTime>=2019-01-01"
$properties = "Title,Path,Author"

$search = Submit-PnPSearchQuery -Query $query -SelectProperties $properties -All

foreach ($row in $search.ResultRows) {


  $data = [PSCustomObject]@{
    "Title"      = $row["Title"]
    "Author"     = $row["Author"]
    "Path"       = $row["Path"]
    "Created"    = $row["Created"]
  }

  $itemsToSave += $data
}

$itemsToSave | Export-Csv -Path $OutFile -NoTypeInformation
