<# Updates user's email address from AD
    Save one user per line in $UserList, format: i:0#.w|postfallscity\amalinusr

View user list:
/_catalogs/users/simple.aspx
/_catalogs/users/detail.aspx
#>

$site = "https://postfallsidahoorg.sharepoint.com"
#$Site = "https://inet.postfallsidaho.org"
$UserList = "\\amalin-pc\c$\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell\Scripts\Users.txt"
$Users = Get-Content $UserList
ForEach ($User in $Users) {
  write-output $user
  (Get-SPUser -Identity $User -Web $Site).email
#  Set-SPUser -Identity $User -Web $Site -SyncFromAD
}

<# 
All users    Skip loop and use this:
    Get-SPUser –Web $Site
    Set-SPUser –SyncFromAD
#>