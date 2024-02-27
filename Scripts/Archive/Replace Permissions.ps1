
#From: https://www.sharepointdiary.com/2016/01/replace-edit-permission-with-contribute-in-sharepoint-powershell.html
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Web Application URL
$WebAppURL="https:\\sharepoint-dev\finance"
 
#Get all webs from the web application
$WebsCollection = Get-SPWebApplication $WebAppURL | Get-SPSite -Limit All | Get-SPWeb  -limit All
 
#Iterate through each web and replace "Edit" to "Contribute"
Foreach ($web in $WebsCollection)
{
    #Get Edit and Contribute permission levels
    $ContributePermission = $web.RoleDefinitions["Contribute"]
    $EditPermission = $web.RoleDefinitions["Edit"]
 
    Write-host "Processing:" $web.Url
 
    If (!$web.HasUniquePerm)
    {
        Write-host -f Yellow "Web is inheriting permissions..."
        continue
    }
 
    #Get all users and groups with Edit permissions
    $RoleAssignmentsColl = $web.RoleAssignments | where {$_.RoleDefinitionBindings -eq $EditPermission}
     
    #Loop through each user/group with Edit permission level
    foreach($RoleAssignment in $RoleAssignmentsColl)
    { 
        #Add Contribute Permissions
        if(!$RoleAssignment.RoleDefinitionBindings.Contains($ContributePermission))
        {
            $RoleAssignment.RoleDefinitionBindings.Add($ContributePermission)
            $RoleAssignment.Update()
            Write-host -f Green "Contribute Permission Added to the User/Group:" $RoleAssignment.Member.Name
        }
  
        #Remove Edit permissions
        if($RoleAssignment.RoleDefinitionBindings.Contains($EditPermission))
        {
            $RoleAssignment.RoleDefinitionBindings.Remove($EditPermission)
            $RoleAssignment.Update()
            Write-host -f Green "Edit Permission removed from the User/Group:" $RoleAssignment.Member.Name
        }
    }
}
