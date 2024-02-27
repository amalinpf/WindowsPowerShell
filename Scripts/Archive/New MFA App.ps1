<#
PowerShell setup app to connect online with MFA	
https://www.sharepointdiary.com/2019/08/connect-sharepoint-online-powershell-using-mfa.html
#>

<#################################################################
For alternate PW for only this app, Create App Password, see: 
https://www.sharepointdiary.com/2019/08/connect-sharepoint-online-powershell-using-mfa.html
https://aka.ms/createapppassword   (https://account.activedirectory.windowsazure.com/AppPasswords.aspx)

$AdminCenterURL = "https://postfallsidahoorg-admin.sharepoint.com"
$AdminUserName = "amalin@postfalls.gov"
$AdminPassword = "rdkhmbrdcbwwgchn" #App Password
 
#Prepare the Credentials
$SecurePassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$Cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $AdminUserName, $SecurePassword
  
#Connect to SharePoint Online
Connect-SPOService -url $AdminCenterURL   #It will prompt
#Connect-SPOService -url $AdminCenterURL -Credential $Cred
##################################################################
#>

<# ???? doesn't work, not needed?
$cred = get-credential -credential amalin@postfalls.gov    # App pw: wxdfxgmznfwtjpnj

#Connect to SharePoint Online services
Connect-SPOService -url $AdminCenterURL -Credential $cred
#Connect-SPOService -url $AdminCenterURL -interactive

 #>

 #Register new app:    https://postfallsidahoorg.sharepoint.com/_layouts/15/AppRegNew.aspx

