$SourceSite = "https://inet.postfallsidaho.org/Finance/"
$DestSite = "https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment/"
$TemplateLoc = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\O365\Templates\Finance\"
$ListsToProcess = $TemplateLoc+".Lists_To_Process.txt"

$lists = Get-Content $ListsToProcess	#One list per line

<# Temp changes:
	$OneOff = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\O365\Templates\Finance\BudReq.xml"
	$lists = @("IT Assets")
	$list = $lists
 #>
 

############################ SAVE Templates ##################################
    Import-Module -name PnP.PowerShell 				# online
    Connect-PnPOnline -Url $DestSite -UseWebLogin -WarningAction Ignore
	get-pnpcontext
    foreach ($list in $lists) {
	#	Set-PnPTraceLog -On -LogFile $TemplateLoc$List"_trace.txt"
		$TemplateName = $list+".xml"
		Write-Host -f cyan "Creating List " $list
		Invoke-PnPSiteTemplate -Path $TemplateLoc$TemplateName -Handlers Lists #-Connection $DestSiteConnect
		Set-PnPTraceLog -Off
	}

