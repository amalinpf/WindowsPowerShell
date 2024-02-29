<# 
Get all sites   https://www.sharepointdiary.com/2016/02/get-all-site-collections-in-sharepoint-online-using-powershell.html
How to quickly enumerate and process all sites, etc.
TODO: Add other iterations as needed
 #>
 
# Set site, etc.
$SitePart = "/sites/CityHallITDept"
$RootPart = "https://postfallsidahoorg.sharepoint.com"
$SiteURL = $RootPart+$SitePart

$AdminSite = "https://postfallsidahoorg-admin.sharepoint.com" 
$TenantURL = $AdminSite     #Often uses this name

$InFile = ".\Input\INFILE_Name.csv"
$OutFile = ".\Output\OUTFILE_Name.csv"
 
######## Site collections ############################################ Get All Site collections 
Connect-PnPOnline -Url $TenantSiteURL -Interactive
Get-PnPTenantSite   # Export to csv: -Detailed | Select Title, URL, Owner, LastContentModifiedDate, WebsCount, Template, StorageUsage | Export-Csv -path $OutFile -NoTypeInformation

######## Sites ########################################### Get All Sites Filtered - Exclude: Seach Center, Redirect site, Mysite Host, App Catalog, Content Type Hub, eDiscovery and Bot Sites
$SiteCollections = Get-PnPTenantSite | Where -Property Template -NotIn ("SRCHCEN#0", "REDIRECTSITE#0", "SPSMSITEHOST#0", "APPCATALOG#0", "POINTPUBLISHINGHUB#0", "EDISC#0", "STS#-1")
    
    ##### Loop through each site collection
    ForEach($Site in $SiteCollections)
    {
        #Get the storage Quota of the site
        Write-host $Site.URL - $Site.StorageQuota
    }


######## Fields ########################################## Select All Fields in Site

$SiteURL = 'https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment'
$OutFile = 'C:\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell\Output\AllFields.csv'

Connect-PnPOnline $SiteURL -Interactive

$lists = Get-PnPList -Includes Fields

foreach($list in $lists)
{
    if (-Not ($list.Hidden)) {
#   $list.Title
    $list.Fields | select scope,title,internalname,typeasstring | export-csv -NoTypeInformation $OutFile -Append
    }
}



################################################### ALTERNATE to process all, slower. PnP PowerShell to Get All Sites and Subsites in SharePoint Online
 
Try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -Interactive
 
    #Get All Site collections  
    $SitesCollection = Get-PnPTenantSite
 
    #Loop through each site collection
    ForEach($Site in $SitesCollection)  
    {  
        Write-host -F Green $Site.Url  
        Try {
            #Connect to site collection
            Connect-PnPOnline -Url $Site.Url -Interactive
 
            #Get Sub Sites Of the site collections
            $SubSites = Get-PnPSubWeb -Recurse
            ForEach ($web in $SubSites)
            {
                Write-host `t $Web.URL
            }
        }
        Catch {
            write-host -f Red "`tError:" $_.Exception.Message
        }
    }
}
Catch {
    write-host -f Yellow "Error:" $_.Exception.Message
}
###############################################

