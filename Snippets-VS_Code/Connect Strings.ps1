$SiteURL = 'https://postfallsidahoorg.sharepoint.com/sites/SiteName'
$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$TenantURL = 'https://postfallsidahoorg.sharepoint.com'
#$ClientID & $ClientSecret  # SHOULD BE DEFINED IN PROFILE
Return  # Don't execute accidentally

########### Connect to site using MFA
Connect-PnPOnline -Url $SiteURL -Interactive -ClientID $ClientID
Disconnect-PnPOnline

########### Online management Shell
# If installation is needed:   Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Confirm:false -Force 
Import-Module Microsoft.Online.SharePoint.PowerShell -UseWindowsPowerShell
Connect-SPOService -url $AdminSiteURL

########### Online management Via Script
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 		# App password, create at  https://aka.ms/createapppassword

Connect-PnPOnline -Url $SiteURL -ClientId $ClientID -ClientSecret $ClientSecret

########### Power Automate
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 
Add-PowerAppsAccount -Endpoint "usgov"	# For GCC, logs in for 8 hours

########### Exchange Online
Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov
Disconnect-ExchangeOnline -Confirm:$False

########### Less common connect variables
$Site = "CityHallITDept"
$Root = "https://postfallsidahoorg.sharepoint.com/sites/" 
$SiteURL = $Root+$Site
