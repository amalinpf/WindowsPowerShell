#---------------------------------------DISCLAIMER----------------------------------------------
#The sample scripts are not supported under any Microsoft standard support program or service. The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, without limitation,
#any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors,
#or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information,
#or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages
#-----------------------------------------------------------------------------------------------

# Provide the server names where the AppPool recycling settings needs to be done
$Servers = Get-Content "C:\temp\remotecomputers.txt"

foreach ($server in $Servers) 
 {
    #Enumerating through each of the remote servers
    Write-Host "********* Looking into the Pools in Server $server********** " -ForegroundColor Magenta
     invoke-command -ComputerName $server -ScriptBlock{
       import-module -Name webadministration
       $pools= dir IIS:\AppPools

    foreach($pool in $pools)
    {
      #Changing the Private Memory limit for the application.
     Write-Host "Changing the Private Memory limit for the $($pool.name) pool" -ForegroundColor Cyan
     Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/applicationPools/add[@name='$($pool.name)']/recycling/periodicRestart" -name "time" -value "00:00:00"

     #Changing the Recycling Memory limit for the application.
     Write-Host "Changing the Recycling time for the $($pool.name) pool" -ForegroundColor Cyan
     Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/applicationPools/add[@name='$($pool.name)']/recycling/periodicRestart" -name "privateMemory" -value 0
     
     Restart-WebAppPool $pool.name
     
     #Checking the Private Memory limit for the application.
     Write-Host "Checking the Private Memory limit for the $($pool.name) pool" -ForegroundColor Yellow
     Get-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/applicationPools/add[@name='$($pool.name)']/recycling/periodicRestart" -name "privateMemory"  | select value,$pool.name

     #Checking the Recycling Memory limit for the application.
     Write-Host "Checking the Recycling time for the $($pool.name) pool" -ForegroundColor Yellow
     Get-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/applicationPools/add[@name='$($pool.name)']/recycling/periodicRestart" -name "time"  | select value,$pool.name
     
     Write-Host " "
    }  
   }
    Write-Host "********* End of the Pools in Server $server********** " -ForegroundColor Magenta
}
