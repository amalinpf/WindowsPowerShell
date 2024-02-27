Connect-SPOService https://postfallsidahoorg-admin.sharepoint.com
$SC = "https://postfallsidahoorg.sharepoint.com/sites/CityEmployeeEvents"

#To view setting
Get-SPOsite $SC | Select DenyAddAndCustomizePages

<#    Write it
Set-SPOsite $SC -DenyAddAndCustomizePages $False
Disconnect-SPOService
#>
