From https://programmerall.com/article/21641239647/


########## exports users from User Profile Service ##########
#$siteUrl = "http://sharepoint-svr:32570/"
#$siteUrl = "http://sharepoint-dev:37869/"
$outputFile = "\\triumph\homes$\amalin\WindowsPowerShell\Output\DEV_sharepoint_user_profiles.csv"
$serviceContext = Get-SPServiceContext -Site $siteUrl
$profileManager = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($serviceContext);
$profiles = $profileManager.GetEnumerator()

$collection = @()
foreach ($profile in $profiles) {
 
   $profileData = "" | 
   select "AccountName", "PreferredName" , "Manager" , "Office" , "Location" , "WorkEmail" , "Assistant" , "AboutMe" , "Language" , "PictureURL" , "Role"
   
   $profileData.AccountName = $profile["AccountName"]
   $profileData.PreferredName = $profile["PreferredName"]
   $profileData.Manager = $profile["Manager"]
   $profileData.Office = $profile["Office"]
   $profileData.Location = $profile["Location"]
   $profileData.WorkEmail = $profile["WorkEmail"]
   $profileData.Assistant = $profile["Assistant"]
   $profileData.AboutMe = $profile["AboutMe"].Value
   $profileData.Language = $profile["Language"]
   $profileData.PictureURL = $profile["PictureURL"]
   $profileData.Role = $profile["Role"]   
   #$collection += $profileData | ConvertTo-Html -Fragment
   $collection += $profileData
}
$collection | Export-Csv $outputFile -NoTypeInformation -encoding "UTF8"

########## Imports users from User Profile Service ##########
# NOT TESTED

$path = "\\triumph\homes$\amalin\WindowsPowerShell\Output\SVR_sharepoint_user_profiles.csv"
#$siteUrl = "http://sharepoint-svr:32570/"
#$siteUrl = "http://sharepoint-dev:37869/"
    $site = $caUrl
    $context = Get-SPServiceContext -Site $site
    $web = Get-SPWeb -Identity $site
    try
    {
    $upm = New-Object -TypeName Microsoft.Office.Server.UserProfiles.UserProfileManager -ArgumentList $context
    }
    catch{}
    if($upm -ne $null)
   {
        $userslist = Import-Csv -Path $path
        $r = 1;
        for($count=0; $count -lt $userslist.Count; $count++)
            {
                 $user_name = $domain +"\"+ $userslist[$count].UserID -replace " ", ""
                 if ($upm.UserExists($user_name)) {} 
                 else  
                 {
                     try
                     {
                         $profileproperty = $upm.CreateUserProfile($user_name)
　　　　　　　　　　　　　　　　$profileproperty["Manager"].Value=''
　　　　　　　　　　　　　　　　$profileproperty["Mail"].Value=''
　　　　　　　　　　　　　　　　$profileproperty["Title"].Value=''
                         　　$profileproperty.Commit()                       
                     }
                     catch
                     {
                      Write-Host -f red ([String]::Format("{0} Not Exist",$user_name));
                     }
                 } 
            }
    }
	