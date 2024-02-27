# From OOS
Get-OfficeWebAppsFarm
(Get-OfficeWebAppsFarm).machines
<#
Remove-OfficeWebAppsMachine
New-OfficeWebAppsFarm -InternalURL "http://oos.postfallsidaho.org/" -AllowHttp -EditingEnabled -OpenFromURLEnabled
# New-OfficeWebAppsFarm -InternalUrl "https://oos.postfallsidaho.org/" -ExternalUrl "https://oos.postfallsidaho.org/" -CertificateName "OfficeWebApps Certificate" -EditingEnabled
#>


# From sharepoint-svr
Get-SPWopiBinding | ft
Get-SPWOPIZone
Set-SPWOPIZone -Zone "external-https"
<#
Remove-SPWOPIBinding –All:$true
New-SPWOPIBinding –ServerName "oos.postfallsidaho.org" -AllowHttp
#>
