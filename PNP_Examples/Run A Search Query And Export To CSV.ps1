<# 
Run A Search Query And Export To CSV
From PNP Powershell - Samples https://pnp.github.io/script-samples/spo-search-export-to-csv/README.html?tabs=pnpps 
Customize as needed (see webpage)
#>

$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$AdminSite = $AdminSiteURL
$dateTime = '_{0:MM_dd_yy}_{0:HH_mm_ss}' -f (Get-Date)
$basePath = '.\Output'
$csvPath = $basePath + '\SearchResults_PnP' + $dateTime + '.csv'
$query = "PromotedState:2"
$properties = "Title,Path,Author"
$itemsToSave = @()

$search = Submit-PnPSearchQuery -Query $query -SelectProperties $properties -All

foreach ($row in $search.ResultRows) {


  $data = [PSCustomObject]@{
    "Title"      = $row["Title"]
    "Author"     = $row["Author"]
    "Path"       = $row["Path"]
  }

  $itemsToSave += $data
}

$itemsToSave | Export-Csv -Path $csvPath -NoTypeInformation
