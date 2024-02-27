<# 
$webUrl="https://inet.postfallsidaho.org/finance"
$webUrl="https://inet.postfallsidaho.org/HR"
$webUrl="https://inet.postfallsidaho.org/clerk"
#>

$webUrl="https://inet.postfallsidaho.org/finance"
$pathToExportReport="\\amalin-pc\c$\Users\amalin\Documents\sharepoint\Scripts\Output\UniqueListPermissions.csv"

Add-PSSnapin Microsoft.SharePoint.PowerShell

$web=Get-SPWeb $webUrl
$lists=$web.Lists

foreach($list in $lists)
{
   Write-Host "Processing list "$list.Title 
   Write-Host "         ...........           Items count: " $list.ItemCount
    $items=$list.Items
    $uniqueItemsCount=0
    foreach($item in $items)
    {
        if($item.HasUniqueRoleAssignments)
        {
            $item | export-csv $pathToExportReport -Append
            $uniqueItemsCount++
        }
    }
    Write-Host "         ...........    Unique items count: " $uniqueItemsCount
}