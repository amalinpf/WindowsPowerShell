# Azure AD group membership		OR USE BULK ACTION IN ENTRA GROUPS

$Group = "pd"
$Tenant = "POSTFALLSIDAHOORG.onMicrosoft.com"
$Outfile = ".\Output\PD_Group_Members.csv"

import-module AzureAD

connect-AzureAD -TenantId $Tenant		
Get-AzureADGroup -SearchString "pd"
	# 81dcf5f8-3017-4521-bf4a-ae13f490e552 PD Users for Intranet 365 & Azure
	
Get-AzureADGroupMember -ObjectId "81dcf5f8-3017-4521-bf4a-ae13f490e552" | select ObjectId, DisplayName, UserPrincipalName, UserType, CreationType, Department | Export-csv -path $OutFile -NoTypeInformation


