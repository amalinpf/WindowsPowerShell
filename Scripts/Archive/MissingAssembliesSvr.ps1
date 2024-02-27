 $wa = Get-SPWebApplication https://inet.postfallsidaho.org/
 $outputPath = "\\triumph\homes$\amalin\Documents\WindowsPowerShell\Output\Test_Wss_Content_MissingAssembly_SVR_$(Get-Date -Format hhmmss).txt"
 $dbName = "WSS_Content"
 $slqServer = "sharepoint-svr"
 Test-SPContentDatabase -Name $dbName -WebApplication $wa -ServerInstance $slqServer -ShowLocation:$true -ExtendedCheck:$false | Out-File $outputPath 
 Write-Host "Test results written to $outputPath"

