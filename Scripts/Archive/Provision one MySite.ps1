Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
  
Function Create-MySite($MySiteHost, $UserAccount) 
{
    #Get Objects
    $ServiceContext  = Get-SPServiceContext -site $MySiteHost
    $UserProfileManager = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($ServiceContext)
 
    #Check if user Exists
    if ($UserProfileManager.UserExists($UserAccount)) 
    {
        #Get the User Profile
        $UserProfile = $UserProfileManager.GetUserProfile($UserAccount)
         
        #Check if User's My site is Cretaed already
        if($UserProfile.PersonalSite -eq $Null)
        {
            $UserProfile.CreatePersonalSite()
            write-host "My Site Created Successfully for the User!" -f Green
        }        
    }
    else
    {
        write-host "$($UserAccount) Not Found!" -f Red
    }
}
 
Create-MySite "https://mysite.sharepoint-dev.postfallscity.com/" "POSTFALLSCITY\amalin"