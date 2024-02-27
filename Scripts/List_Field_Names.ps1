#Config Variables
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment"
$ListName ="Travel Requests"
 
Try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -Interactive
     
    #Get list column internal names
    Get-PnPField -List $ListName
}
Catch {
    Write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}
