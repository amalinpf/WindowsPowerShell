<# Enable SQL Server Agent Jobs
From: https://www.mssqltips.com/sqlservertip/2787/disable-or-enable-sql-server-agent-jobs-using-powershell/
    Lots o' SQL Server PowerShell Tips: https://www.mssqltips.com/sql-server-tip-category/81/powershell/

Install-Module -Name SqlServer -RequiredVersion 21.1.18235 
 #>



$TargetServer = "SharePoint-svr"
$AgentJobs = @("SysBackup - Differential.SystemDiff","SysBackup - Full.Full System Backup subplan","UserBackup - Differential.Subplan_1","UserBackup - Full.Subplan_1","UserBackup - Trans Log.Subplan_1")

Import-Module -Name SqlServer
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO")
$serverInstance = New-Object ("Microsoft.SqlServer.Management.Smo.Server") $TargetServer

foreach ($job in ($serverInstance.JobServer.Jobs) )#| Where-Object {$_.name  -in $AgentJobs})
{
	$job.name
#	$job.isenabled #= $TRUE
#	$job.Alter()
 }
 


<# 
*********** DONE, Notes below ************

List properties, etc.   $serverInstance.JobServer.Jobs | Get-Member

Servers and Maintenance Plans

spsql-svr
$AgentJobs = @("SysBackup - Differential.SystemDiff","SysBackup - Full.SystemFull","UserBackup - Differential.Subplan_1","UserBackup - Full.Subplan_1","UserBackup - Trans Log.UserTrans")

SharePoint-dev
$AgentJobs = @("SysBackup - Differential.Subplan_1","SysBackup - Full.Subplan_1","UserBackup - Differential.Subplan_1","UserBackup - Full.Subplan_1")

SharePoint-svr
$AgentJobs = @("SysBackup - Differential.Subplan_1","SysBackup - Full.Subplan_1","UserBackup - Differential.Subplan_1","UserBackup - Full.Subplan_1")

#>
