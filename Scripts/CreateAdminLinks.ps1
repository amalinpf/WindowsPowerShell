<#  Adds standard Admin Quick Launch links to a site. May have to paste this script into PowerShell ISE
<#  Adds standard Admin Quick Launch links to a site. May have to paste this script into PowerShell ISE
https://pnp.github.io/powershell/cmdlets/Add-PnPNavigationNode.html
https://www.sharepointdiary.com/2018/03/sharepoint-online-powershell-update-quick-launch.html

Use: Check for existing Admin heading in quicklaunch, add new if not. Update $AdminID variable. Add attitional links as desired
#>

#Config Variables
$WebURL = "https://postfallsidahoorg.sharepoint.com"
$SiteURL = "/sites/Demo"
$LinkTitle = "Admin"

#Connect to PnP Online
Connect-PnPOnline -Url "$WebURL$SiteURL" -Interactive
$Context =  Get-PnPContext
 
# ***** Get the Admin ID
$AdminID = Get-PnPNavigationNode -Location QuickLaunch | Where {$_.Title -eq $LinkTitle}  | Select -ExpandProperty ID
If($AdminID -eq $Null)
	{ 
	Write-Host -f Yellow " $WebURL$SiteURL/_layouts/15/AreaNavigationSettings.aspx - No Admin link detected, goto Site Settings Navigation and add Admin as a Heading, save, and re-run."
	}
Else
	{
	$Web = Get-PnPWeb -Includes ID
	$WebID = $Web.Id.tostring()

	# Add Links 
<# 
The GUID for IT_Employees ($AdminID.AudienceIds) is    	
34c1a7cf-1a47-4e4d-9bde-21eea5930d5c

#>
Add-PnPNavigationNode -Title "NITRO Apps" -Url "$siteURL/_layouts/15/appredirect.aspx?client_id=1fecf81a-a6de-47d8-97b9-f23164792f2d&redirect_uri=https%3a%2f%2fnitrostudio.azurewebsites.net%2FPages%2FNitroApps.aspx%3F{StandardTokens}%26r_webId=$WebID" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "NITRO Error Dashboard" -Url "$siteURL/SitePages/Workflow-Errors-Dashboard.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "NITRO Branding" -Url "$siteURL/SitePages/CCSBrandingSettings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Navigation" -Url "$siteURL/_layouts/15/AreaNavigationSettings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Helpful SP URLs" -Url "$siteURL/Lists/Helpful_SP_URLs" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Site Settings" -Url "$siteURL/_layouts/15/settings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Site Contents" -Url "$siteURL/_layouts/15/viewlsts.aspx?view=14" -Location "QuickLaunch" -Parent $AdminID
 	}

