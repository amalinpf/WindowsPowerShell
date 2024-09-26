Return  # Don't execute accidentally

########### Connect to site using MFA
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept"
Connect-PnPOnline -Url $SiteURL -Interactive
Disconnect-PnPOnline

########### Connect to ADMIN site using MFA
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 

########### Via Script
Connect-SPOService -url "https://postfallsidahoorg-admin.sharepoint.com/" 		# App password, create at  https://aka.ms/createapppassword
Connect-PnPOnline -Url $SiteURL -ClientId "ca12s35f-7c48-4xbf-8238-760bc56bdeda" -ClientSecret "J8cFpsg/AS7KUL79fGX1ykbBVkd6q35030AamzAQO5gHj="

########### Power Automate
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-SPOService -url $AdminSiteURL 
Add-PowerAppsAccount -Endpoint "usgov"	# For GCC, logs in for 8 hours

########### Exchange Online if needed
Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov
Disconnect-ExchangeOnline -Confirm:$False
