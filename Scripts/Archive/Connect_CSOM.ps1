#Connects for CSOM:	https://morgantechspace.com/2021/09/connect-to-sharepoint-site-with-mfa-account-using-csom-and-powershell.html
#Install-Module -Name SharePointPnPPowerShellOnline -Force

$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/Generaltesting"

#Add required references to OfficeDevPnP.Core and SharePoint client assembly
[System.Reflection.Assembly]::LoadFrom("C:\Program Files\WindowsPowerShell\Modules\SharePointPnPPowerShell2019\3.29.2101.0\OfficeDevPnP.Core.dll") 
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")
 
$AuthenticationManager = new-object OfficeDevPnP.Core.AuthenticationManager
$ctx = $AuthenticationManager.GetWebLoginClientContext($siteURL)
$ctx.Load($ctx.Web)
$ctx.ExecuteQuery()
  
Write-Host "Title: " $ctx.Web.Title -ForegroundColor Green
Write-Host "Description: " $ctx.Web.Description -ForegroundColor Green
