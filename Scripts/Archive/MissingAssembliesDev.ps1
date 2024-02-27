 $wa = Get-SPWebApplication https://portal.sharepoint-dev.postfallscity.com/
 $outputPath = "\\triumph\homes$\amalin\Documents\WindowsPowerShell\Output\Test_Wss_Content_MissingAssembly_DEV_$(Get-Date -Format hhmmss).txt"
 $dbName = "WSS_Content"
 $slqServer = "sharepoint-dev"
 Test-SPContentDatabase -Name $dbName -WebApplication $wa -ServerInstance $slqServer -ShowLocation:$true -ExtendedCheck:$false | Out-File $outputPath 
 Write-Host "Test results written to $outputPath"

