<# 
Add users to SharePoint group from csv	https://www.sharepointdiary.com/2016/06/sharepoint-online-powershell-to-add-user-to-group.html
#>

#Connection paramaters
#$OnPremURL = "https://inet.postfallsidaho.org/finance"
$OnlineURL = "https://postfallsidahoorg-admin.sharepoint.com/"
$CSVFile="C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\Security\Invoice & CC Approvers for import.csv"
 
#Install-Module Microsoft.Online.SharePoint.PowerShell -Force -AllowClobber
Import-Module Microsoft.Online.SharePoint.PowerShell

Connect to SharePoint ONLINE
Connect-SPOService -url $OnlineURL 
	<# Connect to SharePoint ONPREM     
	######### USE INPUT BOX ON PERMISSIONS PAGE, NO EMAIL ###########
	$Credential = Get-credential -Credential amalin@postfalls.gov
	Connect-SPOService -url $OnPremURL -UseWebAuth
	#>
 
#add multiple users to sharepoint online group powershell - Import Users from CSV
Import-Csv $CSVFile | ForEach-Object { Add-SPOUser -Site $_.SiteURL -Group $_.GroupName -LoginName $_.UserAccount}

<################## .csv template: ######################
SiteURL,GroupName,UserAccount
https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment,<group>,<user>@postfalls.gov

#>

####### You can view groups at: https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment/_layouts/15/user.aspx
