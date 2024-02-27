<#
Enter-PSSession -ComputerName sharepoint-dev.postfallscity.com				# Connect Remotely
Enter-PSSession -ComputerName sharepoint-svr.postfallscity.com				# Connect Remotely
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue	
install-module SharePointPnPPowerShell2019
Update-Module  SharePointPnPPowerShell2019 -force
#>


x	Connect-PnPOnline -Url "https://inet.postfallsidaho.org/Cityhallit" -CurrentCredentials
Connect-PnPOnline -Url "https://inet.postfallsidaho.org/Finance" -CurrentCredentials
Connect-PnPOnline -Url "https://inet.postfallsidaho.org/City Clerk Portal" -CurrentCredentials
Connect-PnPOnline -Url "https://inet.postfallsidaho.org/Community Development" -CurrentCredentials
Connect-PnPOnline -Url "https://inet.postfallsidaho.org/Master Plans" -CurrentCredentials
Connect-PnPOnline -Url "https://inet.postfallsidaho.org/Media Center" -CurrentCredentials
Connect-PnPOnline -Url "https://inet.postfallsidaho.org/Invoice Bucket History" -CurrentCredentials


#Get the Context
$Ctx= Get-PnPContext

#get the lists
$lists = get-pnplist


    foreach ($list in $Lists) 
	{
		if($list.BaseType -eq "DocumentLibrary") 
		{
			$ListName = $List.Name
			Write-Host $ListName


			#Get All Items from the List - Exclude 'Folder' List Items
			$ListItems = Get-PnPListItem -List $List -Query "<View Scope='RecursiveAll'><Query><Where><Eq><FieldRef Name='FSObjType'/><Value Type='Integer'>0</Value></Eq></Where></Query></View>"

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
		}
     }

<#
###############################
#Disable versioning	>>>>  Must do from root
Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue
$site = Get-SPSite https://inet.postfallsidaho.org
foreach($web in $site.AllWebs) {
    Write-Host "Inspecting " $web.Title
    foreach ($list in $web.Lists) {
		  if($list.BaseType -eq "DocumentLibrary") {
            Write-Host $list.Title 
            Write-Host $list.BaseType
            Write-Host "Versioning enabled: " $list.EnableVersioning
            $list.EnableVersioning = $false
#           $list.Update()
            Write-Host $list.Title " Versioning disabled"
            Write-Host 
		  }	
     }
}

#>

