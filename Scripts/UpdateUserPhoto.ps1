<# 
Bulk Import/Update AD user photos   https://woshub.com/how-to-import-user-photo-to-active-directory-using-powershell/
#>
$InFile = "C:\Users\amalin\OneDrive - City of Post Falls\Pictures\Employee Pics\XferUsers.csv" 

import-module azuread
# Install-Module -Name AzureAD
Connect-AzureAD

Import-Csv $InFile |%{Set-ADUser -Identity $_.AD_username -Replace @{thumbnailPhoto=([byte[]](Get-Content $_.Photo -AsByteStream))}}



<# 
#Get existing photo
$Who =  "ddavis"
$ADuser = Get-ADUser $Who -Properties thumbnailPhoto
$ADuser.thumbnailPhoto | Set-Content "C:\Users\amalin\OneDrive - City of Post Falls\Documents\Employee Pics\$Who.jpg" -AsByteStream

# Get users without photo
Get-ADUser -Filter * -properties thumbnailPhoto | ? {(-not($_.thumbnailPhoto))} | select Name


$photo = [byte[]](Get-Content 'C:\Users\amalin\OneDrive - City of Post Falls\Pictures\WIP\Adam Tate.JPG' -Encoding byte)
Set-ADUser atate -Replace @{thumbnailPhoto=$photo}
Notes
[Import-Module ActiveDirectory]

$user = "name"
$ADuser = Get-ADUser $user -Properties thumbnailPhoto
$ADuser.thumbnailPhoto | Set-Content "c:\temp\$user.jpg" -Encoding byte

# One line:
Set-ADUser jcollins -Replace @{thumbnailPhoto=([byte[]](Get-Content "C:\Users\amalin\OneDrive - postfallsidaho.org\Pictures\Employees\Jerry Collins_TR.png" -Encoding byte))}


C:\Users\amalin\OneDrive - City of Post Falls\Pictures\WIP\Adam Tate.JPG

# One line:
Set-ADUser atate -Replace @{thumbnailPhoto=([byte[]](Get-Content "C:\Users\amalin\OneDrive - City of Post Falls\Pictures\WIP\Adam Tate.JPG" -Encoding byte))}


# From https://learn.microsoft.com/en-us/sharepoint/troubleshoot/administration/profile-picture-not-showing

Install-Module Microsoft.Graph -force

Connect-MgGraph -Scopes "User.ReadWrite.All"
Get-MgUserPhotoContent -UserId amalin@postfalls.gov -OutFile "H:\Documents\Pics\amalinGraph.jpg"

Set-ADUser dgreve -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Donald Greve.jpg"-AsByteStream ))}
Set-ADUser jkrous -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Jacob Krous.jpg"-AsByteStream ))}
Set-ADUser jwells -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\James Wells.jpg"-AsByteStream ))}
Set-ADUser jfleshman -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Jaxon Fleshman.jpg"-AsByteStream ))}
Set-ADUser njob -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Naomi Job.jpg"-AsByteStream ))}
Set-ADUser restrada -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Ricky Estrada.jpg"-AsByteStream ))}
Set-ADUser rgross -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Robin Gross.JPG"-AsByteStream ))}
Set-ADUser rlongtin -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Rustin Longtin.jpg"-AsByteStream ))}
Set-ADUser swontorek -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\S Wontorek.jpg"-AsByteStream ))}
Set-ADUser spayne -Replace @{thumbnailPhoto=([byte[]](Get-Content "H:\Documents\Pics\ToUpload\Shawn Payne .jpg"-AsByteStream ))}
 #>