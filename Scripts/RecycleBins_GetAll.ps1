########  Get ALL site collections 
$TenantURL = "https://postfallsidahoorg-admin.sharepoint.com" 
$SCFile = ".\Output\RecycleBins\AllSiteCollections.csv"

#------------  Export them site collections
Connect-PnPOnline -Url $TenantURL -Interactive
Get-PnPTenantSite | Where -Property Template -NotIn ("SRCHCEN#0", "REDIRECTSITE#0", "SPSMSITEHOST#0", "APPCATALOG#0", "POINTPUBLISHINGHUB#0", "EDISC#0", "STS#-1", "TEAMCHANNEL#1")  | select URL, Title | Export-Csv -path $SCFile -NoTypeInformation

#------------ Get Recycle Bins from Site Collections
$InFile = $SCFile

$sc = Import-Csv $InFile 
  
########  Get each site here
foreach ($site in $sc) {
    $OutFile = ".\Output\RecycleBins\" + $site.Title + "_Recycle_Bin.csv"

    $site.title
    Connect-PnPOnline -Url $site.URL -Interactive
    $Web = Get-PnPWeb
  #  Get-PnPRecycleBinItem | Select-Object Id, DirName, Title, Size, DeletedDate, ItemType, ItemState, DeletedByName | export-csv $OutFile
   
    #Get the Site Title
    Write-host -f Green $Web.Title, $site.title    
}



<#
#Restore
Restore-PnpRecycleBinItem -Identity d02bfd8b-26e0-476a-946b-dcf8b52eddae -Force

#Permanently delete
Clear-PnpRecycleBinItem -Identity 7a5d5574-1754-42b0-9777-eec31d919c8c


$site = "https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment"
Connect-PnPOnline -Url $site -Interactive
 
#Get the Root Web
$Web = Get-PnPWeb
 
#Get the Site Title
Write-host -f Green $Web.Title
#>
