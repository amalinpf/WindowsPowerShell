####################################################################################################################
############################## WORKS, DON'T DISTURB! ###############################################################
####################################################################################################################


$site = "https://inet.postfallsidaho.org/cityhallit/"
$list = "ITInvoices"
$dest = "https://postfallsidahoorg.sharepoint.com/sites/CityHallITDept/"
$FileLoc = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\O365\Templates\"
$TemplateName = $list+".xml"

#Import-Module -name PnP.PowerShell 					# online
Import-Module -name SharePointPnPPowerShell2019 	# onsite
$SourceConnect = Connect-PnPOnline -Url $site -useweblogin -WarningAction Ignore -ReturnConnection 

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
Connect-PnPOnline -Url $dest -UseWebLogin -WarningAction Ignore
#get-pnpcontext
Write-Host -f cyan "Creating List " $list
Invoke-PnPSiteTemplate -Path $FileLoc$TemplateName -Handlers Lists -WarningAction Ignore #-Connection $DestConnect

<#
Disconnect-PnPOnline 
Disconnect-PnPOnline -Connection $SourceConnect
Disconnect-PnPOnline -Connection $DestConnect
Remove-Module -name PnP.PowerShell 					# So commands don't conflict with onprem ones...

Set-PnPTraceLog -On -LogFile $FileLoc$List"_trace.txt"
Set-PnPTraceLog -Off

#>






write-output "$FileLoc$List_trace.txt"
