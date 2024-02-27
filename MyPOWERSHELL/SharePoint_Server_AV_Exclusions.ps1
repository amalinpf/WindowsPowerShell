#Added Windows Defender exceptions (https://support.microsoft.com/en-us/office/certain-folders-may-have-to-be-excluded-from-antivirus-scanning-when-you-use-file-level-antivirus-software-in-sharepoint-01cbc532-a24e-4bba-8d67-0b1ed733a3d9?ui=en-us&rs=en-us&ad=us

### Use REMOVE-MpPreference to undo ###

Install-Module -name "WindowsDefender"
# if no worky, Import-Module WindowsDefender first

#To view existing
Get-MpPreference | Select-Object -expand ExclusionPath
Get-MpPreference | Select-Object -expand ExclusionProcess
Get-MpPreference | Select-Object -expand ExclusionExtension

# IIS
Add-MpPreference -ExclusionPath "%ProgramData%\Microsoft\SharePoint","%ProgramFiles%\Common Files\Microsoft Shared\Web Server Extensions","%ProgramFiles%\Microsoft Office Servers\16.0\Data\Office Server\Applications","%WinDir%\Microsoft.NET\Framework64\v4.0.30319\Config","%WinDir%\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files","%WinDir%\System32\LogFiles","%WinDir%\Syswow64\LogFiles","C:\inetpub\temp\IIS Temporary Compressed Files","C:\inetpub\wwwroot\wss\VirtualDirectories ","C:\Users\*\AppData\Local\Temp"

###########################
#Microsoft SQL Server AV exclustions https://support.microsoft.com/en-us/topic/how-to-choose-antivirus-software-to-run-on-computers-that-are-running-sql-server-feda079b-3e24-186b-945a-3051f6f3a95b

#Directory
Add-MpPreference -ExclusionPath "D:\Microsoft SQL Server","%ProgramFiles%\Microsoft SQL Server\.\FTDATA","%ProgramFiles%\Microsoft Office Servers\16.0\Data\Office Server\Applications"

#Extension
Add-MpPreference -ExclusionExtension "*.mdf","*.ldf","*.ndf","*.bak","*.trn"

#Process
Add-MpPreference -ExclusionProcess "%ProgramFiles%\Microsoft SQL Server\.\MSSQL\Binn\SQLServr.exe","%ProgramFiles%\Microsoft SQL Server\.\Reporting Services\ReportServer\Bin\ReportingServicesService.exe","%ProgramFiles%\Microsoft SQL Server\.\OLAP\Bin\MSMDSrv.exe"


###########################
#Microsoft SharePoint Server AV exclustions https://support.microsoft.com/en-us/office/certain-folders-may-have-to-be-excluded-from-antivirus-scanning-when-you-use-file-level-antivirus-software-in-sharepoint-01cbc532-a24e-4bba-8d67-0b1ed733a3d9

#Directory
Add-MpPreference -ExclusionPath "%WinDir%\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files","%WinDir%\Microsoft.NET\Framework64\v4.0.30319\Config","%ProgramData%\Microsoft\SharePoint","C:\BlobCache"


