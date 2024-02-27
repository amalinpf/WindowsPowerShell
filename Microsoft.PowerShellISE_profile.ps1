<# 
$PROFILE
$PROFILE.AllUsersCurrentHost    
$PROFILE.CurrentUserCurrentHost

1/10/23 ajm, put back to default, just Notepad++ shortcut
5/2/23 ajm, shortened prompt to current path
2/16/24 ajm, Modified for OneDrive rename to 'City of Post Falls' from 'postfallsidaho.org'
#>

# Add np as a shortcut to notepad++
if(!(Test-Path alias:np)) { new-alias np "C:\Program Files (x86)\Notepad++\notepad++.exe" }

# Make screen 3000x3000 (otherwise columns are cut off on the right)
$buffer = $host.ui.RawUI.BufferSize; 
$buffer.width = 3000; 
$buffer.height = 3000; 
$host.UI.RawUI.Set_BufferSize($buffer)

# Set home location
#Set-Variable -Name home -Force -Value ($env:HOMEDRIVE + $env:HOMEPATH + "`\WindowsPowerShell")   # GPO seems to overwright ENV variables
Set-Variable -Name home -Force -Value "C:\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell"
set-location $home
function prompt {(get-location).drive.root + "..\" + (Split-Path -Path $pwd -leaf) + ">"}
