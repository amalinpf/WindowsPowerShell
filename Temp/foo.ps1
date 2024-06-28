$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/MediaDepartment"
 
#Connect to Tenant Admin
Connect-PnPOnline $SiteURL -Interactive
 
#Enable Custom Scripting by turning OFF Deny Flag
<# 
Set-PnPTenantSite -Identity $SiteURL -DenyAddAndCustomizePages:$false
 #>
Get-PnPSite   | select DenyAddAndCustomizePages, NoScriptSite
Set-PnPSite -Identity $SiteURL -NoScriptSite $false

