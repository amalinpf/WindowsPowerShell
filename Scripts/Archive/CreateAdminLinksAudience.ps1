<#  Adds standard Admin Quick Launch links to a site. May have to paste this script into PowerShell ISE
https://pnp.github.io/powershell/cmdlets/Add-PnPNavigationNode.html
https://www.sharepointdiary.com/2018/03/sharepoint-online-powershell-update-quick-launch.html
Use: Check for existing Admin, add new if not. Update $AdminID variable. Add additional links as desired

Audience code from https://ktttw.de/powercorner/?p=346
#>

#Config Variables
$WebURL = "https://postfallsidahoorg.sharepoint.com"
$SiteURL = "/sites/PUD"
$LinkTitle = "Admin"
$AudienceName = "IT_Employees"

# Connect to PnP Online
Connect-PnPOnline -Url "$WebURL$SiteURL" -Interactive

# Get Audience GUID
$audienceList = New-Object System.Collections.Generic.List[guid]    
$group = Get-PnPMicrosoft365Group | where-object{$_.GroupDisplayname -eq $AudienceName }
$groupId = $group.GroupId
$audienceList.add([System.guid]::New($groupId)) 
$context = Get-PnPContext
 
# ***** Get the Admin ID
$AdminID = Get-PnPNavigationNode -Location QuickLaunch | Where {$_.Title -eq $LinkTitle}  | Select -ExpandProperty ID
If($AdminID -eq $Null)
	{ 
	Write-Host -f Yellow "No Admin link detected, goto Site Settings Navigation ($WebURL/_layouts/15/AreaNavigationSettings.aspx) and add Admin as a Heading, save, and re-run."
	}
Else
	{
	# Add the audience to Admin and update the node object
<# 	$AdminID.AudienceIds = $audienceList
	$AdminID.Update()
	Invoke-PnPQuery
 #>
	$Web = Get-PnPWeb -Includes ID
	$WebID = $Web.Id.tostring()

	# Add Links 
	Add-PnPNavigationNode -Title "NITRO Apps" -Url "$siteURL/_layouts/15/appredirect.aspx?client_id=1fecf81a-a6de-47d8-97b9-f23164792f2d&redirect_uri=https%3a%2f%2fnitrostudio.azurewebsites.net%2FPages%2FNitroApps.aspx%3F{StandardTokens}%26r_webId=$WebID" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "NITRO Error Dashboard" -Url "$siteURL/SitePages/Workflow-Errors-Dashboard.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Site Contents" -Url "$siteURL/_layouts/15/viewlsts.aspx?view=14" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Site Settings" -Url "$siteURL/_layouts/15/settings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Navigation" -Url "$siteURL/_layouts/15/AreaNavigationSettings.aspx" -Location "QuickLaunch" -Parent $AdminID
	Add-PnPNavigationNode -Title "Helpful SP URLs" -Url "$siteURL/Lists/Helpful_SharePoint_URLs" -Location "QuickLaunch" -Parent $AdminID

 	}

write-output $AdminID



