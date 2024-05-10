<# Doesn't run with F5.
Configure to run with F5, in the meantime:
Run manually to Connect.
Then run Connect.
Then GetInactiveSites.
 #>


$adminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$dateTime = "_{0:MM_dd_yy}_{0:HH_mm_ss}" -f (Get-Date)
$basePath = ".\Output"
$csvPath = $basePath + "\InActiveSites_PnP" + $dateTime + ".csv"
$global:inActiveSites = @()
$daysInActive = 30

 
Function GetInactiveSites {    
    try {
        Write-Host "Getting inactive sites..." -ForegroundColor Yellow 
        $siteCollections = Get-PnPTenantSite | Where-Object {$_.Url -notlike "-my.sharepoint.com" -and $_.Url -notlike "/portals/"}
         
        #calculate the Date
        $date = (Get-Date).AddDays(-$daysInActive).ToString("MM/dd/yyyy")
 
        #Get inactive sites based on modified date
        $global:inActiveSites = $siteCollections | Where {$_.LastContentModifiedDate -le $date} | Select *         
       
        Write-Host "Getting inactive sites successfully!"  -ForegroundColor Green 
    }
    catch {
        Write-Host "Error in getting inactive sites:" $_.Exception.Message -ForegroundColor Red                 
    }
    Write-Host "Exporting to CSV..."  -ForegroundColor Yellow 
    $global:inActiveSites | Export-Csv $csvPath -NoTypeInformation -Append
    Write-Host "Exported to CSV successfully!"  -ForegroundColor Green	
}

Write-Host "Connecting to Site '$($adminSiteURL)'..." -ForegroundColor Yellow   
Connect-PnPOnline -Url $adminSiteURL -Interactive
Write-Host "Connection Successful!" -ForegroundColor Green 

GetInactiveSites
