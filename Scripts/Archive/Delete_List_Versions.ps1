<#
Enter-PSSession -ComputerName sharepoint-dev.postfallscity.com				# Connect Remotely
Enter-PSSession -ComputerName sharepoint-svr.postfallscity.com				# Connect Remotely
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue	
install-module SharePointPnPPowerShell2019
Update-Module  SharePointPnPPowerShell2019
#>


#Remove previous versions from a site:

#Config Variables
$SiteURL = "https://inet.postfallsidaho.org"
$ListName = "Invoice Bucket"


#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -CurrentCredentials

#Get the Context
$Ctx= Get-PnPContext

#Get All Items from the List - Exclude 'Folder' List Items
$ListItems = Get-PnPListItem -List $ListName -Query "<View Scope='RecursiveAll'><Query><Where><Eq><FieldRef Name='FSObjType'/><Value Type='Integer'>0</Value></Eq></Where></Query></View>"

ForEach ($Item in $ListItems)
{
    #Get File Versions
    $File = $Item.File
    $Versions = $File.Versions
    $Ctx.Load($File)
    $Ctx.Load($Versions)
    $Ctx.ExecuteQuery()

    Write-host -f Yellow "Scanning File:"$File.Name
    $VersionsCount = $Versions.Count
    If($VersionsCount -gt 0)
    {
        write-host -f Cyan "`t Total Number of Versions of the File:" $VersionsCount
        #Delete versions
        For($i=0; $i -lt $VersionsCount; $i++)
        {
            write-host -f Cyan "`t Deleting Version:" $Versions[0].VersionLabel
            $Versions[0].DeleteObject()
        }
        $Ctx.ExecuteQuery()
        Write-Host -f Green "`t Version History is cleaned for the File:"$File.Name
    }
}

<#
###############################
#Disable versioning
Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue
$site = Get-SPSite http://sharepoint-dev/cityhallit
foreach($web in $site.AllWebs) {
    Write-Host "Inspecting " $web.Title
    foreach ($list in $web.Lists) {
            Write-Host $list.Title 
            Write-Host $list.BaseType
            Write-Host "Versioning enabled: " $list.EnableVersioning
            $list.EnableVersioning = $false
#           $list.Update()
            Write-Host $list.Title " Versioning disabled"
            Write-Host 
     }
}
#>
