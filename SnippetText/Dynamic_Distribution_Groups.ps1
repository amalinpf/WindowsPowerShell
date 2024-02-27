Return  # Don't execute accidentally

$Group = "City Hall IT Employees"
Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov

#Get Membership:
Get-DynamicDistributionGroupMember -Identity $Group 

#Get Last Membership Refresh time
(Get-DynamicDistributionGroup -Identity $Group).CalculatedMembershipUpdateTime

#Force Membership Refresh, Must wait at least an hour since last:
Set-DynamicDistributionGroup -Identity $Group -ForceMembershipRefresh

<#
Disconnect-ExchangeOnline -Confirm:$False
 #>
