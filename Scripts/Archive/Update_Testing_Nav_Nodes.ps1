<#
Update Quick Launch Links		https://www.sharepointdiary.com/2018/03/sharepoint-online-powershell-update-quick-launch.html
	$Context.ExecuteQuery()		If it doesn't work, check $Context.HasPendingRequest should be false
	TODO:	 Loopify
#>

$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/TestHub2/ittesting"
$NavNode = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept"
$LinkTitle = "TestingLink2"
$AdminLink = "Admin"

#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Get the Context
$Context =	Get-PnPContext
 
$AdminID = Get-PnPNavigationNode -Location QuickLaunch | Where {$_.Title -eq $AdminLink}  | Select -ExpandProperty ID
<#	If($AdminID)
		{ 
		Write-Host -f green " $SC.Full_URL/_layouts/15/AreaNavigationSettings.aspx - Found $AdminLink link."
		}
	Else
		{
		Write-Host -f Yellow " $SC.Full_URL/_layouts/15/AreaNavigationSettings.aspx - No Admin link detected, goto Site Settings Navigation and add Admin as a Heading, save, and re-run."
		}
 #>
#Get the Quick Launch Navigation
$AdminNode = Get-PnPNavigationNode -id $AdminID
 
#Get the Link to Update
$NavigationNode = $AdminNode.children | Where-Object { $_.Title -eq	 $LinkTitle}
If($NavigationNode)
{
	#Update the Link URL
	$NavigationNode.Url = $SiteURL
	$navigationNode.Update() 
	$Context.ExecuteQuery()
	Write-host -ForegroundColor Green "Navigation Link $LinkTitle has been updated to $SiteURL"
}
Else
	{
	$Web = Get-PnPWeb -Includes ID
	$WebID = $Web.Id.tostring()
	# Add Links 
	Add-PnPNavigationNode -Title $LinkTitle -Url $NavNode -Location "QuickLaunch" -Parent $AdminID
	 Write-host -ForegroundColor Yellow "Navigation Link $LinkTitle has been created to $NavNode"
	}


<# 
See CreateAdminLinks.ps1
	Add-PnPNavigationNode -Title "NITRO Apps" -Url "$siteURL/_layouts/15/appredirect.aspx?client_id=1fecf81a-a6de-47d8-97b9-f23164792f2d&redirect_uri=https%3a%2f%2fnitrostudio.azurewebsites.net%2FPages%2FNitroApps.aspx%3F{StandardTokens}%26r_webId=$WebID" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "NITRO Error Dashboard" -Url "$siteURL/SitePages/Workflow-Errors-Dashboard.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "NITRO Branding" -Url "$siteURL/SitePages/CCSBrandingSettings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Site Contents" -Url "$siteURL/_layouts/15/viewlsts.aspx?view=14" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Site Settings" -Url "$siteURL/_layouts/15/settings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Navigation" -Url "$siteURL/_layouts/15/AreaNavigationSettings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Helpful SP URLs" -Url "$siteURL/Lists/Helpful_SP_URLs" -Location "QuickLaunch" -Parent $AdminID
#>