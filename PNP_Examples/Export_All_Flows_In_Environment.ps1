$environmentName = "postfalls.gov (default)"
$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$AdminSite = $AdminSiteURL
$AdminURL = $AdminSiteURL
$TenantURL = 'https://postfallsidahoorg.sharepoint.com'
$dateTime = '_{0:MM_dd_yy}_{0:HH_mm_ss}' -f (Get-Date)
$basePath = '.\Output'
$csvPath = $basePath + '\FILENAME_PnP' + $dateTime + '.csv'

Connect-PnPOnline $adminSiteURL -Interactive



$FlowEnv = Get-PnPPowerAutomateEnvironment | Where-Object { $_.Properties.DisplayName -eq $environmentName }
Get-PnPPowerAutomateEnvironment
Write-Host "Getting All Flows in $environmentName Environment"
$flows = Get-PnPFlow -Environment $FlowEnv -AsAdmin #Remove -AsAdmin Parameter to only target Flows you have permission to access

Write-Host "Found $($flows.Count) Flows to export..."

foreach ($flow in $flows) {

    Write-Host "Exporting as ZIP & JSON... $($flow.Properties.DisplayName)"
    $filename = $flow.Properties.DisplayName.Replace(" ", "")
    $timestamp = Get-Date -Format "yyyymmddhhmmss"
    $exportPath = "$($filename)_$($timestamp)"
    $exportPath = $exportPath.Split([IO.Path]::GetInvalidFileNameChars()) -join '_'
    Export-PnPFlow -Environment $FlowEnv -Identity $flow.Name -PackageDisplayName $flow.Properties.DisplayName -AsZipPackage -OutPath "$exportPath.zip" -Force
    Export-PnPFlow -Environment $FlowEnv -Identity $flow.Name | Out-File "$exportPath.json"

}

