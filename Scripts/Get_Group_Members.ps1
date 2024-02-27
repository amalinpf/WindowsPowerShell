<# 
Get Group Members
https://www.sharepointdiary.com/2018/01/sharepoint-online-powershell-get-group-members.html
#>

$SiteURL="https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment"
Connect-PnPOnline -Url $SiteURL -interactive

#Repeat below for each group
 
$GroupName= "Finance Department Members"
Get-PnPGroupMember -Identity $GroupName
