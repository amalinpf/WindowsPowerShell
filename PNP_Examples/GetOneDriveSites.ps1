
$adminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$dateTime = "_{0:MM_dd_yy}_{0:HH_mm_ss}" -f (Get-Date)
$basePath = ".\Output"
$csvPath = $basePath + "\OneDriveSites_PnP" + $dateTime + ".csv"
$global:onedriveSitesCollection = @()

Function GetOnedriveSitesDetails {    
    try {
        Write-Host "Getting onedrive sites..."  -ForegroundColor Yellow 
        $global:onedriveSitesCollection = Get-PnPTenantSite -IncludeOneDriveSites -Filter "Url -like '-my.sharepoint.com/personal/'" | select *          
    }
    catch {
        Write-Host "Error in getting onedrive sites:" $_.Exception.Message -ForegroundColor Red                 
    }
    Write-Host "Exporting to CSV..."  -ForegroundColor Yellow 
    $global:onedriveSitesCollection | Export-Csv $csvPath -NoTypeInformation -Append
    Write-Host "Exported to CSV successfully!"  -ForegroundColor Green	
}

Write-Host "Connecting to Site '$($adminSiteURL)'..." -ForegroundColor Yellow   
Connect-PnPOnline -Url $adminSiteURL -Interactive
Write-Host "Connection Successful!" -ForegroundColor Green 
    
GetOnedriveSitesDetails


