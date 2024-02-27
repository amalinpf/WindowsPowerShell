# This will target all Nintex Workflow History lists, you can change the threshold to filter down.
# This is used to find where the lists are and if they are larger than the threshold.
# This will target the entire farm, you may want to scope it down to site collection.

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue
#Lists with values higher than threshold will be returned
[int]$threshold = 200
function Get-SPListCollection {
PARAM
(
[Parameter(ValueFromPipeline=$true)] [Microsoft.SharePoint.SPWeb] $SPWeb
)
BEGIN {
  }
END {
}
PROCESS {
  $SPWeb.Lists
  $SPWeb = $null
  [GC]::Collect()
}
}
$(Get-SPWebApplication) | Get-SPSite -Limit ALL | Get-SPWeb -Limit ALL | Get-SPListCollection | WHERE {$_.BaseTemplate -eq "WorkflowHistory"} | where {$_.ItemCount -ge $threshold} | FL ParentWeb, Title, ItemCount 
