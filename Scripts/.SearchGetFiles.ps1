$AdminSiteURL = "https://postfallsidahoorg-admin.sharepoint.com/"

$searchTerms = '"Falls City Development" AND (Entitlements OR Dedications)'
$ItemsDownloaded = 0
$FileNameScrubbed = $searchTerms.replace('"', "'")
$csvFile = "C:\Temp\Legal\CSV\SearchResults($FileNameScrubbed).csv"
$PrevSite = ''

$DestinationFolder = "C:\Temp\Legal\$FileNameScrubbed"
#Check if the Destination Folder exists. If not, create the folder for targetfile
If (!(Test-Path -Path $DestinationFolder)) {
  New-Item -ItemType Directory -Path $DestinationFolder | Out-Null
  Write-host -f Yellow "Created a New Folder '$DestinationFolder'"
}

#Connect-PnPOnline -url $AdminSiteURL -UseWebLogin
$FileList = Import-Csv $csvFile 

ForEach ($FileName in $FileList) {
  $SiteURL = $FileName.Site
  $FilePath = $FileName.path -as [uri]
    
  Try {
  
    Write-host ($ItemsDownloaded + 1) $FileName.Title
    If ( $SiteURL -ne $PrevSite){
      Connect-PnPOnline -Url $SiteURL -interactive
    }
    
    #Check if File exists
    $File = Get-PnPFile -Url $FilePath.LocalPath -ErrorAction SilentlyContinue
    If ( $Null -ne $File) {
      #Download file from sharepoint online
      Get-PnPFile -Url $FilePath.LocalPath -Path $DestinationFolder -Filename $File.Name -AsFile -Force
      $ItemsDownloaded += 1
    }
    Else {
      Write-host "Could not Find File at "$FilePath.LocalPath -f Red
    }
  }
  Catch {
    write-host "Error: $($_.Exception.Message)" $File.Name -foregroundcolor Red
  }

  $PrevSite = $SiteURL
}
Write-host $ItemsDownloaded " files downloaded" 
