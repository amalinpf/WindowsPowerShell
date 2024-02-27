<#
Update Quick Launch Links		https://www.sharepointdiary.com/2018/03/sharepoint-online-powershell-update-quick-launch.html
    $Context.ExecuteQuery()                     Doesn't work
#>

$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/TestHub2/ittesting"
$LinkTitle = "Helpful SP URLs"
$AdminLink = "Admin"

#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Get the Context
$Context =  Get-PnPContext
 
$AdminID = Get-PnPNavigationNode -Location QuickLaunch | Where {$_.Title -eq $AdminLink}  | Select -ExpandProperty ID
	If($AdminID)
		{ 
		Write-Host -f green " $SC.Full_URL/_layouts/15/AreaNavigationSettings.aspx - Found $AdminLink link."
		}
	Else
		{
		Write-Host -f Yellow " $SC.Full_URL/_layouts/15/AreaNavigationSettings.aspx - No Admin link detected, goto Site Settings Navigation and add Admin as a Heading, save, and re-run."
		}

#Get the Quick Launch Navigation
$AdminNode = Get-PnPNavigationNode -id $AdminID
 
#Get the Link to Update
$NavigationNode = $AdminNode.children | Where-Object { $_.Title -eq  $LinkTitle}
If($NavigationNode)
{
    #Update the Link URL
    $NavigationNode.Url = "https://support.crescent.com"
    $navigationNode.Update() 
    $Context.ExecuteQuery()
    Write-host "Navigation Link has been updated!"
}