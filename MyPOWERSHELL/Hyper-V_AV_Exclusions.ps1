#Added Windows Defender exceptions (https://support.microsoft.com/en-us/office/certain-folders-may-have-to-be-excluded-from-antivirus-scanning-when-you-use-file-level-antivirus-software-in-sharepoint-01cbc532-a24e-4bba-8d67-0b1ed733a3d9?ui=en-us&rs=en-us&ad=us:

### Use REMOVE-MpPreference to undo ###

Install-Module -name "WindowsDefender"
# if no worky, Import-Module WindowsDefender first

#To view existing
Get-MpPreference | Select-Object -expand ExclusionPath
Get-MpPreference | Select-Object -expand ExclusionProcess
Get-MpPreference | Select-Object -expand ExclusionExtension

###########################
#Hyper-V exclusions https://docs.microsoft.com/en-us/troubleshoot/windows-server/virtualization/antivirus-exclusions-for-hyper-v-hosts
#defaults per role https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-antivirus/configure-server-exclusions-microsoft-defender-antivirus

#Extension
Add-MpPreference -ExclusionExtension "*.vhds","*.vhdpmem"

#Process
Add-MpPreference -ExclusionProcess "vmcompute.exe","*.vmrs","*.vmgs","Vmsp.exe","Vmcompute.exe"

#Directory
Add-MpPreference -ExclusionPath "C:\Hyper-V","D:\Hyper-V","D:\Backups","D:\WindowsImageBackup","D:\Virtual Harddisks","D:\Virtual Machines"

