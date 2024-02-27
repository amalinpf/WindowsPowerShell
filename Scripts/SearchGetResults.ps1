<#
$OutFile = ".\Output\SearchResults.csv"   

$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-PnPOnline -url $AdminSiteURL  -interactive

$itemsToSave = @()

$query = "{Jerod Harwood} LastModifiedTime>=2019-01-01"
$properties = "Title,Created,Site,Path"

$search = Submit-PnPSearchQuery -Query $query -SelectProperties $properties -All

foreach ($row in $search.ResultRows) {


  $data = [PSCustomObject]@{
    "Title"      = $row["Title"]
    "Created"    = $row["Created"]
    "Site"       = $row["SPWebUrl"]
    "Path"       = $row["Path"]
  }

  $itemsToSave += $data
}

$itemsToSave | Export-Csv -Path $OutFile -NoTypeInformation


Download a file
#>
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
$Test = $false

If ($test) {
   $DestinationFolder ="C:\Temp\Test"
   $Infile = ".\Output\SearchResultsTest.csv"

}
else{
   $DestinationFolder ="C:\Temp"
   $Infile = ".\Output\SearchResults.csv"
}


#Import-Module PnP.PowerShell
Connect-PnPOnline -url $AdminSiteURL -UseWebLogin
$FileList = Import-Csv $InFile 
ForEach ($FName in $FileList) {
    $SiteURL = $FName.Site
    $FilePath = $FName.path  -as [uri]
    
#Try {
  
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -UseWebLogin
     
    #Check if File exists
    $File = Get-PnPFile -Url $FilePath.LocalPath -ErrorAction SilentlyContinue
    If( $Null -ne $File)
    {
        #Download file from sharepoint online
        Get-PnPFile -Url $FilePath.LocalPath -Path $DestinationFolder -Filename $File.Name -AsFile -Force
        Write-host "File Downloaded Successfully!" -f Green
    }
    Else
    {
        Write-host "Could not Find File at "$FilePath.LocalPath -f Red
    }
#}
#Catch {
 #   write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
#}

Disconnect-PnPOnline
}

