Return  # Don't execute accidentally

$AdminSite = "https://postfallsidahoorg-admin.sharepoint.com" 
$SiteCollection = "https://postfallsidahoorg.sharepoint.com/sites/SITE"

Connect-SPOService -Url $AdminSite 
Set-SPOsite $SiteCollection -DenyAddAndCustomizePages 0

