<#
3/10/21 ajm, To update Script files, etc.
Got some tips from: https://www.meziantou.net/convert-cmd-script-to-powershell.htm

#>
$DestHosts = @('amalin-surface', 'sharepoint-dev', 'sharepoint-svr', 'SPSQL-SVR', 'hypervspdev-svr', 'exch2016-svr', 'hyperv2019-svr', 'monitor-pc', 'amalin-vpc')
#Others , 'shadowbdc-svr', 'triumph', 'vmoos-svr', 'vmpdc2016-svr'

$LogFile = 'C:\Users\amalin\Documents\WindowsPowerShell\Scripts\Logs\BGinfoUpdate.log'
$Source = 'C:\Scripts\Bginfo\'
$Dest = 'C:\Scripts\'

date | Out-File $LogFile -append


foreach ($PC in $DestHosts)
{
$Session = New-PSSession -ComputerName $PC 
    $PC  | Out-File $LogFile -append
    Copy-Item $Source -Destination $Dest -recurse -force -ToSession $Session  | Out-File $LogFile -append
    Copy-Item 'C:\Program Files (x86)\Notepad++\plugins\' -Destination 'C:\Program Files (x86)\Notepad++\' -recurse -force -ToSession $Session  | Out-File $LogFile -append
    Remove-PSSession $Session
}
Write-Output '************** DONE' | Out-File $LogFile -append

