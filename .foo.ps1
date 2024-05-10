
$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$AdminSite = $AdminSiteURL
$SiteURL = 'https://postfallsidahoorg.sharepoint.com/sites/SiteName'
$environmentName = "postfalls.gov (default)"
$FlowEnv = $environmentName

Connect-PnPOnline $AdminSite -Interactive
<# 
https://learn.microsoft.com/en-us/answers/questions/1354866/how-to-add-company-name-for-a-bulk-of-user-in-azur
9/20/23 ajm, To bulk update AzureAD attributes
#>

#Attributes to update
$CompanyName = "Post Falls PD"
$Deptname = "PD"

$OutFile = ".\Output\All Users.csv"  # CSV FILE WITH ONE VALUE PER LINE, column names in first row
$InFile = ".\Input\PD Users.csv" 
import-module azuread
# Install-Module -Name AzureAD
Connect-AzureAD

# Get list of all users
Get-AzureADUser -All $true | Export-Csv -Path $OutFile -NoTypeInformation

Write it here AFTER Modifying $OutFile and saving it to $Infile


$InFile = 'H:\Documents\Pics\AllUsers.csv'
$Users = Import-Csv $InFile 
ForEach($user in $Users) {

    $Who =  $user.who
Write-Output $who
    $ADuser = Get-ADUser $Who -Properties thumbnailPhoto
    $ADuser.thumbnailPhoto | Set-Content "H:\Documents\Pics\$Who.jpg" -AsByteStream
}

Get-MgUserPhoto -UserId amalin@postfalls.gov

$InFile = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\Employee Pics\XferUsers.csv" 	#[AD_username,Photo]
#Connect-MgGraph
Connect-MgGraph -Scopes "User.ReadWrite.All"
Import-Csv $InFile | %{Set-MgUserPhotoContent -UserId $_.AD_username -InFile $_.Photo}

Remove-MgUserPhoto -UserId atonasket@postfalls.gov

#Using Graph API:	https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/change-user-profile-photos?view=o365-worldwide
Connect-MgGraph
Set-MgUserPhotoContent -UserId roneill@postfalls.gov -InFile ""C:\Users\amalin\OneDrive - City of Post Falls\Pictures\Employee Pics\roneill.jpg"

# Update multiple in Graph API:
$InFile = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\Employee Pics\XferUsers.csv" 	#[AD_username,Photo]
Connect-MgGraph -Scopes "User.ReadWrite.All"
Import-Csv $InFile | %{Set-MgUserPhotoContent -UserId $_.AD_username -InFile $_.Photo}


#download User_Photo
Get-MgUserPhotoContent -UserId <UPN> -OutFile _PhotoPathAndFileName_
#Multiple
Import-Csv $InFile | %{Get-MgUserPhotoContent -UserId $_.AD_username -OutFile _PhotoPathAndFileName_}

#Remove User_Photo
Remove-MgUserPhoto -UserId <UPN>
#Multiple
Import-Csv $InFile | Remove-MgUserPhoto -UserId $_.AD_username}

#Can also do it for groups:
Set-MgGroupPhotoContent -GroupId _GUID_ -InFile "_PhotoPathAndFileName_"


