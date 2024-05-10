$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$AdminSite = $AdminSiteURL
$SiteURL = 'https://postfallsidahoorg.sharepoint.com/sites/SiteName'

am

$Credential = Get-Credential
Connect-MgGraph -Credential $Credential

Import-Module Microsoft.Online.SharePoint.PowerShell

Connect-SPOService -Url $AdminSiteURL


$users = Get-Content -path "C:\Temp\Users.txt"
Request-SPOPersonalSite -UserEmails $users

Uninstall-Module -Name Microsoft.Online.SharePoint.PowerShell -Force
Install-Module -Name Microsoft.Online.SharePoint.PowerShell -force

############################################## https://learn.microsoft.com/en-us/sharepoint/pre-provision-accounts

$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$user = "rellis@postfalls.gov"

# Import-Module Microsoft.Online.SharePoint.PowerShell
Connect-SPOService -Url  $AdminSiteURL
Request-SPOPersonalSite -UserEmails $user

xxxxxxxxxxxxxxxxx

Get-Module -ListAvailable -name 'Microsoft.Online.SharePoint.PowerShell' # | select version, name				# Match name 

Install-Module Microsoft.Online.SharePoint.PowerShell -Force -AllowClobber			# Install named module
Uninstall-Module -Name Microsoft.Online.SharePoint.PowerShell -AllVersions -Force		# 16.0.24810.12000
Install-Module Microsoft.Online.SharePoint.PowerShell -Force -AllowClobber			# Install named module
Import-Module Microsoft.Online.SharePoint.PowerShell

uninstall-module -Name Microsoft.Online.SharePoint.PowerShell -MinimumVersion 16.0.24810.12000

