Return  # Don't execute accidentally

########### Connect to site using MFA
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept"
$ClientID = 'ef961be7-5d2e-4fab-af48-7c08697b2dd2'
Connect-PnPOnline -Url $SiteURL -Interactive -ClientID $ClientID
Disconnect-PnPOnline

########### Connect to ADMIN site using MFA
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 

########### Via Script
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 		# App password, create at  https://aka.ms/createapppassword

$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept"
$ClientID = 'ef961be7-5d2e-4fab-af48-7c08697b2dd2'
Connect-PnPOnline -Url $SiteURL -ClientId "ca12s35f-7c48-4xbf-8238-760bc56bdeda" -ClientSecret "J8cFpsg/AS7KUL79fGX1ykbBVkd6q35030AamzAQO5gHj="

########### Power Automate
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 
Add-PowerAppsAccount -Endpoint "usgov"	# For GCC, logs in for 8 hours

########### Exchange Online if needed
Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov
Disconnect-ExchangeOnline -Confirm:$False

########### Online management Shell
# If installation is needed:   Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Confirm:false -Force 
Import-Module Microsoft.Online.SharePoint.PowerShell -UseWindowsPowerShell
Connect-SPOService -url AdminSiteURL
