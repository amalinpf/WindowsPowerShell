# From Nintex to remove custom content types
$siteURL = "https://portal.sharepoint-dev.postfallscity.com/"
$contentType = "$Resources:NWResource,_ContentType_Task_Name;" 
$web = Get-SPWeb $siteURL
$ct = $web.ContentTypes[$contentType] 
if ($ct) { 
	
	$ctusage = [Microsoft.SharePoint.SPContentTypeUsage]::GetUsages($ct)
	foreach ($ctuse in $ctusage) {
		$list = $web.GetList($ctuse.Url) 
		$contentTypeCollection = $list.ContentTypes; 
		$contentTypeCollection.Delete($contentTypeCollection[$ContentType].Id); 
		Write-host "Deleted $contentType content type from $ctuse.Url" 
 } $ct.Delete() 
 Write-host "Deleted $contentType from site." 
} 
else { Write-host "Nothing to delete." } 
$web.Dispose()
#