####################################################################################################################
############################## WORKS, DON'T DISTURB! ###############################################################
####################################################################################################################


$site = "https://inet.postfallsidaho.org/cityhallit/"
$list = "ITInvoices"
$dest = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept/"
$FileLoc = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\O365\Templates\2019toSPO\"
$TemplateName = $list+".xml"

#Import-Module -name PnP.PowerShell 					# online
Import-Module -name SharePointPnPPowerShell2019 	# onsite
$SourceConnect = Connect-PnPOnline -Url $site -useweblogin -ReturnConnection

Write-Host -f green "Creating List Template " $list
Export-PnPListToProvisioningTemplate -Out $FileLoc$TemplateName -List $list -Connection $SourceConnect
Write-Host -f yellow "Populating List Template " $list
Add-PnPDataRowsToProvisioningTemplate -Path $FileLoc$TemplateName -List $list #-Connection $SourceConnect

<#
Disconnect-PnPOnline
Remove-Module -name SharePointPnPPowerShell2019 	# So commands don't conflict with online ones...
#>

# Create the online list with all data

#Import-Module -name PnP.PowerShell 					# online
#$DestConnect = Connect-PnPOnline -Url $dest -UseWebLogin -ReturnConnection
Connect-PnPOnline -Url $dest -UseWebLogin
Write-Host -f cyan "Creating List " $list
Invoke-PnPSiteTemplate -Path $FileLoc$TemplateName -Handlers Lists #-Connection $DestConnect

<#
Disconnect-PnPOnline -Connection $SourceConnect
Disconnect-PnPOnline -Connection $DestConnect
Remove-Module -name PnP.PowerShell 					# So commands don't conflict with onprem ones...
#>






write-output $FileLoc$TemplateName
