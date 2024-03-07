##### SCRIPT
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityClerkDepartment"
$GroupName = "Everyone except external users"     #But you assign it as a user
$cclib = "CrowCanyonAppsLib"
$sa = "SiteAssets"
$sp = "SitePages"

#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -interactive

#Break Permission Inheritance of the List, then Grant permission on list to Group
Set-PnPList -Identity $cclib -BreakRoleInheritance -CopyRoleAssignments
Set-PnPListPermission -Identity $cclib -AddRole "Read" -User $GroupName

Set-PnPList -Identity $sa -BreakRoleInheritance -CopyRoleAssignments
Set-PnPListPermission -Identity $sa -AddRole "Read" -User $GroupName

Set-PnPList -Identity $sp -BreakRoleInheritance -CopyRoleAssignments
Set-PnPListPermission -Identity $sp -AddRole "Read" -User $GroupName
