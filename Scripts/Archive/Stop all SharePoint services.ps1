<# 
10/13/20 ajm, 	To stop and start all SharePoint related services, from: https://www.sharepointdiary.com/2015/10/how-to-stop-and-start-all-sharepoint-2013-services.html
				Snippets used to backup server.

USAGE:			Run the Display, Stop, or Start snippet. Services are also disabled when stopped to prevent inadvertent starting.
				Can be run from a remote computer as-is, remove the 'Invoke-Command' line and closing } to run locally on server
				
TODO:			Add logging to file

HISTORY:	
#>

<# 
***************************************************************************************************************************************************************
# DISPLAY DISPLAY DISPLAY DISPLAY DISPLAY DISPLAY DISPLAY current status **************************************************************************************
***************************************************************************************************************************************************************
 #>
Invoke-Command -ComputerName sharepoint-dev -ScriptBlock{
Add-PSSnapin Microsoft.sharepoint.powershell -ErrorAction SilentlyContinue
$SharePointServices = ('MSSQLSERVER','SPSearchHostController','OSearch16','SPWriterV4','SPUserCodeV4','SPTraceV4','SPTimerV4','SPAdminV4','W3SVC')
 
#Get all SharePoint Services
foreach ($Service in $SharePointServices)
{
    Get-Service -Name $Service
}
}

EXIT	#Stop in case accidentally run	


<# 
***************************************************************************************************************************************************************
STOP STOP STOP STOP STOP STOP STOP STOP STOP all SharePoint Services ******************************************************************************************
***************************************************************************************************************************************************************
#>
Invoke-Command -ComputerName sharepoint-dev -ScriptBlock{
Add-PSSnapin Microsoft.sharepoint.powershell -ErrorAction SilentlyContinue
$SharePointServices = ('SPAdminV4','SPTimerV4','SPTraceV4','SPUserCodeV4','SPWriterV4','W3SVC','OSearch16','SPSearchHostController')

foreach ($Service in $SharePointServices)
{
    Set-Service -Name $Service -StartupType Disabled
    Stop-Service -Name $Service
    Get-Service -Name $Service
}
#Stop IIS
iisreset /stop
}

<# 
***************************************************************************************************************************************************************
START START START START START START START START START all SharePoint Services *********************************************************************************
***************************************************************************************************************************************************************
 #>
Invoke-Command -ComputerName sharepoint-dev -ScriptBlock{
Add-PSSnapin Microsoft.sharepoint.powershell -ErrorAction SilentlyContinue
$SharePointServices = ('W3SVC','SPAdminV4','SPTimerV4','SPTraceV4','SPUserCodeV4','SPWriterV4','OSearch16','SPSearchHostController')
 
#Start all SharePoint Services
foreach ($Service in $SharePointServices)
{
    Set-Service -Name $Service -StartupType Automatic
    Start-Service -Name $Service
    Get-Service -Name $Service
}
}

