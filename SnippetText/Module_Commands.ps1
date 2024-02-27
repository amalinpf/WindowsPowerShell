﻿Return  # Don't execute accidentally

############### Module Commands 

Get-Module -ListAvailable | Select Name,Version,path	# All installed in $env:psmodulepath
Get-Module -ListAvailable -name '*pnp*'					# Match name

Find-Module	-Name psname								# Check PowerShell Gallery
Find-Command -Name get-foo -Repository PSGallery		# Check PowerShell Gallery
Find-Module	-Name psname | Install-Module				# Go ahead and install it

Update-Module -Force -verbose			# All modules
Update-Module PNP.Powershell -Force -verbose	# One module

Install-Module PNP.Powershell -Force -AllowClobber			# Install named module
Uninstall-Module -Name MSOnline -AllVersions -Force		# Uninstall named module

############### Uninstall previous versions of one module
$PSItem = Get-InstalledModule pnp.powershell
$CurrentVersion = $PSItem.Version
Get-InstalledModule -Name $PSItem.Name -AllVersions | Where-Object -Property Version -LT -Value $CurrentVersion | Uninstall-Module -Verbose

############### Uninstall all previous versions of all modules
Get-InstalledModule | ForEach-Object {
    $CurrentVersion = $PSItem.Version
    Get-InstalledModule -Name $PSItem.Name -AllVersions | Where-Object -Property Version -LT -Value $CurrentVersion
} | Uninstall-Module -Verbose

###############  CURRENT SESSION
Get-InstalledModule			# All in current session
Import-Module MSOnline		# Current session
Remove-Module MSOnline		# Current session

############### Modules Used 
AzureAD                                        
ExchangeOnlineManagement                       
Microsoft.Graph			# Includes lots of sub-modules                   
Microsoft.Online.SharePoint.PowerShell         
Microsoft.PowerApps.Administration.PowerShell  
Microsoft.PowerApps.PowerShell                 
MicrosoftTeams                                 
MSOnline                                       
PackageManagement                              
PnP.PowerShell                                 
PowerShellGet                                  
PSFramework                                    
WindowsDefender  
