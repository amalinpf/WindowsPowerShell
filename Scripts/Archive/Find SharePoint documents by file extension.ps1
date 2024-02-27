# Variables
$siteUrl = "http://sharepoint-dev/cityhallit"
$FileType = "docx"
 
$LogFile = "C:\Users\amalin\Documents\POWERSHELL\File Type - $FileType.csv"
 
#Connect to SPO
Connect-PnPOnline -Url $siteUrl -UseWebLogin
 
#Store in variable all the document libraries in the site
$DocLibrary = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 } 
 
$results = @()
foreach ($DocLib in $DocLibrary) {
 
    #Get list of all items in the document library
    $AllItems = Get-PnPListItem -PageSize 1000 -List $DocLib -Fields "ID"
     
    #Loop through each files/folders in the document library for folder size = 0
    foreach ($Item in $AllItems) {
        if ($Item["FileLeafRef"] -like "*.$FileType") {
 
            Write-Host "Item:" $Item["FileRef"] -ForegroundColor Yellow
                 
            #Creating object to export in .csv file
            $results += [pscustomobject][ordered] @{
                ID       = $Item["ID"] 
                FileName = $Item["FileLeafRef"] 
                FilePath = $Item["FileRef"]
            }
             
        }#end of IF statement
    }
}
$results | Export-Csv -Path $LogFile -NoTypeInformation