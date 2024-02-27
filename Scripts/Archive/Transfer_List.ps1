$site = "https://inet.postfallsidaho.org/cityhallit/"
$list = "KnowBe4"
$dest = "https://postfallsidahoorg.sharepoint.com/sites/Generaltesting/"
$FileLoc = "C:\Temp\Templates\"
$TemplateName = "PNPTest.xml"

Import-Module -name SharePointPnPPowerShell2019 	# onsite
Connect-PnPOnline -Url $site -currentcredentials

Write-Host -f green "Creating List " $list
Export-PnPListToProvisioningTemplate -Out $FileLoc$TemplateName -List $list
Write-Host -f yellow "Populating List " $list
Add-PnPDataRowsToProvisioningTemplate -Path $FileLoc$TemplateName -List $list

Disconnect-PnPOnline
Remove-Module -name SharePointPnPPowerShell2019 	# So commands don't conflict with online ones...

<# Create the online list with all data

Import-Module -name PnP.PowerShell 					# online
Connect-PnPOnline -Url $dest -UseWebLogin

Write-Host -f cyan "Creating List " $list
Invoke-PnPSiteTemplate -Path $FileLoc$TemplateName -Handlers Lists

Disconnect-PnPOnline
Remove-Module -name PnP.PowerShell 					# So commands don't conflict with onprem ones...
#>


