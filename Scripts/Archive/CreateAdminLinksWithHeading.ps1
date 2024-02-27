 
#Config Variables
$WebURL = "https://postfallsidahoorg.sharepoint.com"
$SiteURL = "/sites/Variances"
$LinkTitle = "Admin2"





 
Try {
#Connect to PnP Online
Connect-PnPOnline -Url "$WebURL$SiteURL" -Interactive
     
    #Add a Link to Top Navigation Bar
    Add-PnPNavigationNode -Title $LinkTitle -Location QuickLaunch
 
    #Get the Navigation node $LinkTitle
    $ParentID = Get-PnPNavigationNode -Location QuickLaunch | Where {$_.Title -eq $LinkTitle}  | Select -ExpandProperty ID
    #Add a link under $LinkTitle
Add-PnPNavigationNode -Title "NITRO Apps" -Url "$siteURL/_layouts/15/appredirect.aspx?client_id=1fecf81a-a6de-47d8-97b9-f23164792f2d&redirect_uri=https%3a%2f%2fnitrostudio.azurewebsites.net%2FPages%2FNitroApps.aspx%3F{StandardTokens}%26r_webId=$WebID" -Location QuickLaunch -Parent $ParentID
	Add-PnPNavigationNode -Title "NITRO Error Dashboard" -Url "$siteURL/SitePages/Workflow-Errors-Dashboard.aspx" -Location QuickLaunch -Parent $ParentID
	Add-PnPNavigationNode -Title "NITRO Branding" -Url "$siteURL/SitePages/CCSBrandingSettings.aspx" -Location QuickLaunch -Parent $ParentID
	Add-PnPNavigationNode -Title "Site Contents" -Url "$siteURL/_layouts/15/viewlsts.aspx?view=14" -Location QuickLaunch -Parent $ParentID
	Add-PnPNavigationNode -Title "Site Settings" -Url "$siteURL/_layouts/15/settings.aspx" -Location QuickLaunch -Parent $ParentID
	Add-PnPNavigationNode -Title "Navigation" -Url "$siteURL/_layouts/15/AreaNavigationSettings.aspx" -Location QuickLaunch -Parent $ParentID
	Add-PnPNavigationNode -Title "Helpful SP URLs" -Url "$siteURL/Lists/Helpful_SP_URLs" -Location QuickLaunch -Parent $ParentID
  
    Write-host "Quick Launch Links Added Successfully!" -f Green
}
catch {
    write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}