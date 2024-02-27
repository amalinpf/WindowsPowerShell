Return  # Don't execute accidentally

$GroupName="Department Heads 365"
$UserProperties = @()		# initialize array to hold results

Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov

#List group members
$GroupMembers = Get-UnifiedGroup -Identity $GroupName | Get-UnifiedGroupLinks -LinkType Member | Sort-Object DisplayName

# Iterate through each user and retrieve the required properties
$UserProperties = @()
foreach ($User in $GroupMembers) {
    $UserProperties += $User | Select-Object DisplayName, Department, Title
}

# Display the user properties
$UserProperties | Format-Table -AutoSize
