#Config Variables
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/hrdept"
$CSVFile = "H:\Documents\WindowsPowerShell\Output\SPO_UserData.csv"
#$Cred = Get-Credential -Credential amalin@postfallsidaho.org

Connect-PnPOnline -Url $SiteURL -Credentials $cred  #-Interactive 
  
#Get All users of the site collection
$Users = Get-PnPUser
$UserData=@()
 
#Loop through Users and get properties
ForEach ($User in $Users)
{
    $UserData += New-Object PSObject -Property @{
        "User Name" = $User.Title
        "Login ID" = $User.LoginName
        "E-mail" = $User.Email
        "User Type" = $User.PrincipalType
    }
}
$UserData
#Export Users data to CSV file
$UserData | Export-Csv -NoTypeInformation $CSVFile

