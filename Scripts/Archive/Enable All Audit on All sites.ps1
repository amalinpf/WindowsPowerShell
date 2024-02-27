
#Turn on all access logging
$DaysToKeep = 30	#Days to keep before trim

[Microsoft.SharePoint.SPSecurity]::RunWithElevatedPrivileges(
{
   $sites = Get-SPSite -Limit All
   foreach($site in $sites)
   {
       $site.Audit.AuditFlags = $site.Audit.AuditFlags = [Microsoft.SharePoint.SPAuditMaskType]::CheckOut `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::CheckIn `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::View `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Delete `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Update `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::ProfileChange `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::ChildDelete `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::SchemaChange `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::SecurityChange `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Undelete `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Workflow `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Copy `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Move `
-bxor [Microsoft.SharePoint.SPAuditMaskType]::Search
       $site.Audit.Update()

#Set Trimming Options
$Site.TrimAuditLog = $true
$Site.AuditLogTrimmingRetention = $DaysToKeep
#write-host  $site.Path
#write-host  $site.UserIsSiteAdminInSystem
$site.Dispose()
   }
})

<#
# Audit report
# Doesn't quite work right

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue
[Microsoft.SharePoint.SPSecurity]::RunWithElevatedPrivileges(
{
  $sites = Get-SPSite -Limit All
  foreach($site in $sites)
  {
      $auditQuery = New-Object Microsoft.SharePoint.SPAuditQuery($site)
      $auditLogs = $site.Audit.GetEntries($auditQuery)
      foreach($logEntry in $auditLogs)
      {
        $user = $site.RootWeb.SiteUsers.GetByID($logEntry.UserId).Name
#        Write-Host "Document: " $logEntry.DocLocation " Event: " $logEntry.Event " User: " $user " Details: " $logEntry.EventData | Out-File -ascii -append -FilePath C:\Users\amalin\Documents\Powershell\PSoutput\EnableAudit.log
        echo "Document: " $logEntry.DocLocation " Event: " $logEntry.Event " User: " $user " Details: " $logEntry.EventData | Out-File -FilePath C:\Users\amalin\Documents\Powershell\PSoutput\EnableAudit.log -append
      }
  }
})

#>
