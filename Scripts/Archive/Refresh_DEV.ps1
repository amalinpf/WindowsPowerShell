<# 
4/8/22 ajm, Refreshes WSS_Content on DEV from PROD
	Run script on DEV
#>

############## Stop/Disable SharePoint Services ##############
$SharePointServices = ('OSearch16','SPSearchHostController','SPTraceV4','SPTimerV4','SPAdminV4','W3SVC')
Write-Host -ForegroundColor red "Disabling/Stopping SharePoint Server Services -------------------------"
foreach ($Service in $SharePointServices){
    Set-Service -Name $Service -StartupType Disabled -PassThru
    Stop-Service -Name $Service
}
iisreset /stop
Pause


############## Verify SharePoint Service Status ##############
$SharePointServices = ('W3SVC','SPAdminV4','SPTimerV4','SPTraceV4','SPSearchHostController','OSearch16')
Write-Host -ForegroundColor yellow "SharePoint Server Service status -----------------------------------------"
foreach ($Service in $SharePointServices){
    Get-Service -Name $Service
}
iisreset /status
Pause


############## Copy databases ##############
$via = '\\sharepoint-dev\xfer\Refresh_DEV'
Start-Transcript  -Path "$via\RefreshSvrToDev.txt" -Append
Import-Module dbatools
$svr = "sharepoint-svr"
$dev = "sharepoint-dev"
$SourceDB = "WSS_Content"
$DestDB = "new name"
$via = '\\sharepoint-dev\xfer\Refresh_DEV'
$cred = Get-Credential -Credential amalin@postfallsidaho.org
$startDbaCopySplat = @{
	Source = $svr
	Destination = $dev
	Database = $SourceDB
#	NewName = $DestDB		#Can only be used when copying ONE DB
	BackupRestore = $true
	WithReplace = $true
	SharedPath = $via
	NoBackupCleanup = $true
	SourceSqlCredential = $cred
	DestinationSqlCredential = $cred
}
Copy-DbaDatabase @startDbaCopySplat -Force | Select-Object * | Out-GridView
Stop-Transcript
Pause


############## Enable/Start SharePoint Services ##############
$SharePointServices = ('W3SVC','SPAdminV4','SPTimerV4','SPTraceV4','SPSearchHostController','OSearch16')
Write-Host -ForegroundColor green "Starting SharePoint Server Services ----------------------------------"
foreach ($Service in $SharePointServices){
    Set-Service -Name $Service -StartupType Automatic -PassThru
    Start-Service -Name $Service
}
iisreset /start
