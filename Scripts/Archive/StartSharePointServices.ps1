Add-PSSnapin Microsoft.sharepoint.powershell -ErrorAction SilentlyContinue
 
#SPInsights and SPUserCodeV4 already disabled, add back in if needed. Likewise with SPWriterV4, it is already set to manual. Not necessary to include MSSQLFDLauncher

#With SQL
#$SharePointServices = ('MSSQLSERVER','SQLSERVERAGENT','SQLWriter','SQLServerReportingServices','SQLBrowser','SQLTELEMETRY','W3SVC','SPAdminV4','SPTimerV4','SPTraceV4','SPSearchHostController','OSearch16')
$SharePointServices = ('W3SVC','SPAdminV4','SPTimerV4','SPTraceV4','SPSearchHostController','OSearch16')
 
#Start all SharePoint Services
foreach ($Service in $SharePointServices)
{
    Write-Host -ForegroundColor yellow "Starting $Service..."
    Set-Service -Name $Service -StartupType Automatic
    Start-Service -Name $Service
}

