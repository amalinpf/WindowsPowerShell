<# 10/5/20 ajm, to Start SharePoint update process https://blogit.create.pt/miguelisidoro/2019/05/02/how-to-speed-up-the-installation-of-sharepoint-cumulative-updates-using-powershell-step-by-step/
#>

$path="c:\Import\SharePoint\Updates"
Import-Module $path\SharePointPatchScript.psm1
#Get-SPPatch -Path $path -KBs 4484505
Install-SPPatch -Path $path -Pause

