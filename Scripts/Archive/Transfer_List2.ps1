$site = "https://inet.postfallsidaho.org/cityhallit/"
$list = "KnowBe4"
$dest = "https://postfallsidahoorg.sharepoint.com/sites/Generaltesting/"
$FileLoc = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\O365\Templates\"
$TemplateName = "PNPTest.xml"

Import-Module -name SharePointPnPPowerShell2019 	# onsite
Set-PnPTraceLog -On -LogFile $FileLoc"debug.txt" -Level debug
Connect-PnPOnline -Url $site # -currentcredentials

Write-Host -f green "Creating List " $list
Get-PnPSiteTemplate -Out $FileLoc$TemplateName -Handlers Lists
# Write-Host -f yellow "Populating List " $list
# Add-PnPDataRowsToProvisioningTemplate -Path $FileLoc$TemplateName -List $list

Disconnect-PnPOnline
Set-PnPTraceLog -On
Remove-Module -name SharePointPnPPowerShell2019 	# So commands don't conflict with online ones...

<# Create the online list with all data

Import-Module -name PnP.PowerShell 					# online
Connect-PnPOnline -Url $dest -UseWebLogin

Write-Host -f cyan "Creating List " $list
Invoke-PnPSiteTemplate -Path $FileLoc$TemplateName -Handlers Lists

Disconnect-PnPOnline
Remove-Module -name PnP.PowerShell 					# So commands don't conflict with onprem ones...
#>
