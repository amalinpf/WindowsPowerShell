#  http://sharepointsharks.blog/sharepoint-search-and-high-cpu-usage/


# Write the Header line to a new CSV File (this drops it in the current directory): "Page URL, Closed Web Part Name" | out-file ClosedWebParts.csv
# Get all Webs from the Site:
$webs = Get-SPWebApplication "https://sharepoint-dev" | Get-SPSite -Limit All | Get-SPWeb -Limit All
$OutFile = '\\amalin-pc\c$\Users\amalin\Documents\SharePoint\Scripts\Output\ClosedWebParts.csv'

# Loop through each of the Web Sites found (note: you MUST be SCA when running this!)
foreach ($web in $webs)
{
# Get All Pages from site's Root into $AllPages Array
#
$AllPages = @($web.Files | Where-Object {$_.Name -match ".aspx"})
# Search All Folders for All Pages
#
foreach ($folder in $web.Folders)
{
#Add the pages to $AllPages Array
$AllPages += @($folder.Files | Where-Object {$_.Name -match ".aspx"})
}
# Loop through all of the pages and check each:
#
foreach($Page in $AllPages)
{
$webPartManager = $web.GetLimitedWebPartManager($Page.ServerRelativeUrl,[System.Web.UI.WebControls.WebParts.PersonalizationScope]::Shared)
# Use an array to hold a list of the closed web parts:
#
$closedWebParts = @()
foreach ($webPart in $webPartManager.WebParts | Where-Object {$_.IsClosed})
{
$result = "$($web.site.Url)$($Page.ServerRelativeUrl), $($webpart.Title)"
Write-Host "Closed Web Part(s) Found at URL: "$result
$result | Out-File $OutFile -Append
$closedWebParts += $webPart
}
}
}

<# 
#SCRIPT TO DELETE CLOSED WEB PARTS ON ALL PAGES:
# Write the Header line to a new CSV File (this drops it in the current directory):
#"Page URL, Closed Web Part Name" | out-file ClosedWebParts.csv
# Get all Webs from the Site:
#
$webs = Get-SPWebApplication "http://<your URL>" | Get-SPSite -Limit All | Get-SPWeb -Limit All
# Loop through each of the Web Sites found (note: you MUST be SCA when running this!)
#
foreach ($web in $webs)
{
# Get All Pages from site's Root into $AllPages Array
#
$AllPages = @($web.Files | Where-Object {$_.Name -match ".aspx"})
# Search All Folders for All Pages
#
foreach ($folder in $web.Folders)
{
#Add the pages to $AllPages Array
$AllPages += @($folder.Files | Where-Object {$_.Name -match ".aspx"})
}
# Loop through all of the pages and check each:
#
foreach($Page in $AllPages)
{
$webPartManager = $web.GetLimitedWebPartManager($Page.ServerRelativeUrl,[System.Web.UI.WebControls.WebParts.PersonalizationScope]::Shared)
# Use an array to hold a list of the closed web parts:
#
$closedWebParts = @()
foreach ($webPart in $webPartManager.WebParts | Where-Object {$_.IsClosed})
{
$result = "$($web.site.Url)$($Page.ServerRelativeUrl), $($webpart.Title)"
Write-Host "Closed Web Part(s) Found at URL: "$result
$result | Out-File ClosedWebParts.csv -Append
$closedWebParts += $webPart
}
# Delete Closed Web Parts
#
foreach ($webPart in $closedWebParts)
{
Write-Host "Deleting '$($webPart.Title)' on $($web.site.Url)/$($page.Url)"
$webPartManager.DeleteWebPart($webPart) 
}
}
}
 #>

# resources :
# https://social.technet.microsoft.com/Forums/azure/en-US/a5e7c464-5652-4d61-8280-1988d4950748/microsoft-sharepoint-search-component-running-high-in-cpu99-in-task-manager-sharepoint-2013?forum=sharepointadmin
