$SourceSite = "https://inet.postfallsidaho.org/Finance/"
$DestSite = "https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment/Migrate/"
$TemplateLoc = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\O365\Templates\Finance\"
$ListsToProcess = $TemplateLoc+".Lists_To_Process.txt"
 
$lists = Get-Content $ListsToProcess	#One list per line

<# Temp changes:
	$OneOff = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\O365\Templates\Finance\BudReq.xml"
	$lists = @("Dept Approvers")
	$list = $lists
 #>
 

############################# GET Templates ##################################
    Import-Module -name SharePointPnPPowerShell2019 	# onsite
	# -CurrentCredentials first, then -UseWebLogin if it stops working
	$SourceConnect = Connect-PnPOnline -Url $SourceSite -CurrentCredentials -WarningAction Ignore -ReturnConnection 
	#$SourceConnect = Connect-PnPOnline -Url $SourceSite -WebLogin -WarningAction Ignore -ReturnConnection 

	foreach ($list in $lists) {
 	#	Set-PnPTraceLog -On -LogFile $TemplateLoc$List"_trace.txt"
		$TemplateName = $list+".xml"
		Write-Host -f green "Creating List Template " $list
		Export-PnPListToProvisioningTemplate -Out $TemplateLoc$TemplateName -List $list -force -Connection $SourceConnect
	 	############################ ADD DATA to Template ##################################

			Write-Host -f yellow "Populating List Template " $list
			Add-PnPDataRowsToProvisioningTemplate -Path $TemplateLoc$TemplateName -List $list #-Connection $SourceConnect
			# Add-PnPDataRowsToProvisioningTemplate -Path $OneOff -List $list 
		
		Set-PnPTraceLog -Off
	}

<# ############################ SAVE Templates ##################################
	Disconnect-PnPOnline
    Import-Module -name PnP.PowerShell 				# online
    Connect-PnPOnline -Url $DestSite -UseWebLogin -WarningAction Ignore
	get-pnpcontext
    foreach ($list in $lists) {
	#	Set-PnPTraceLog -On -LogFile $TemplateLoc$List"_trace.txt"
		$TemplateName = $list+".xml"
		Write-Host -f cyan "Creating List " $list
		Invoke-PnPSiteTemplate -Path $TemplateLoc$TemplateName -Handlers Lists -WarningAction Ignore #-Connection $DestSiteConnect
		Set-PnPTraceLog -Off
	}
#>
