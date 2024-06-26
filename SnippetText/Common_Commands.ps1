﻿Return  # Don't execute accidentally

############ Common commands
# Avoid line wrapping
$buffer = $host.ui.RawUI.BufferSize; 
$buffer.width = 3000; 
$buffer.height = 3000; 
$host.UI.RawUI.Set_BufferSize($buffer)

############ Conditional Filter
$SourceListFields = Get-PnPField -List $SourceList -Connection $SourceConn | Where { (-Not ($_.ReadOnlyField)) -and (-Not ($_.Hidden)) -and ($_.InternalName -ne  "ContentType") -and ($_.InternalName -ne  "Attachments" -and $_.Title -notlike "*Archive*" -and $_.Title -notin $ExcludedLists) }
If($FieldType -eq "User" -or $FieldType -eq "UserMulti"){...}

############ Comparison Operators
-eq -ne -gt -ge -lt -le -notin (array) -notlike (*wildcard*)    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.3

############ Common variables sitepart rootpart
$AdminSite = "https://postfallsidahoorg-admin.sharepoint.com" 

$Site = "CityHallITDept"
$Root = "https://postfallsidahoorg.sharepoint.com/sites/" 
$SiteURL = $Root+$Site

$InFile = ".\Input\INFILE_Name.csv"
$OutFile = ".\Output\OUTFILE_$Site.csv"

Connect-PnPOnline -Url $SiteURL -Interactive
