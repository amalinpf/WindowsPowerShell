<# 
4/28/23 ajm, Get All Documents in a Site
	https://www.sharepointdiary.com/2018/03/sharepoint-online-get-all-documents-using-powershell.html
	
 #>	
 
#Parameters
$SitePart = "/sites/CityClerkDepartment"
$RootPart = "https://postfallsidahoorg.sharepoint.com"   
$SiteURL = $RootPart+$SitePart

$Ext = "PDF"
$OutFN = $Ext + $SitePart.replace('/','_') + ".csv"
$CSVPath = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell\Scripts\Output\$Ext_$OutFN"

$global:DocumentInventory = @()
$Pagesize = 2000
  
#Function to scan and collect Document Inventory
Function Get-DocumentInventory
{
     [cmdletbinding()]
    param([parameter(Mandatory = $true, ValueFromPipeline = $true)] $Web)
    
    Write-host "Getting Documents Inventory from Site '$($Web.URL)'" -f Yellow
    Connect-PnPOnline -Url $Web.URL -Interactive
 
    #Calculate the URL of the tenant
    If($Web.ServerRelativeUrl -eq "/")
    {
        $TenantURL = $Web.Url
    }
    Else
    {
        $TenantURL = $Web.Url.Replace($Web.ServerRelativeUrl,'')
    }
  
    #Exclude certain libraries
    $ExcludedLists = @("Form Templates", "Preservation Hold Library","Site Assets", "Pages", "Site Pages", "Images", "Site Collection Documents", "Site Collection Images","Style Library") 
                                
    #Get All Document Libraries from the Web
    Get-PnPList -PipelineVariable List | Where-Object {$_.BaseType -eq "DocumentLibrary" -and $_.Hidden -eq $false -and $_.Title -notlike "*Archive*" -and $_.Title -notin $ExcludedLists -and $_.ItemCount -gt 0} | ForEach-Object {
        #Get Items from List   
        $global:counter = 0;
        Write-host "Retrieving Documents from Library: $($List.Title)" -f Cyan
       $ListItems = Get-PnPListItem -List $_ -PageSize $Pagesize -Fields Author, Created, File_x0020_Type,File_x0020_Size -ScriptBlock `
                 { Param($items) $global:counter += $items.Count; Write-Progress -PercentComplete ($global:Counter / ($_.ItemCount) * 100) -Activity "Getting Documents from '$($_.Title)'" -Status "Processing Items $global:Counter to $($_.ItemCount)";} | Where {$_.FileSystemObjectType -eq "File"}
        Write-Progress -Activity "Completed Retrieving Documents from Library $($List.Title)" -Completed
      
            #Get Root folder of the List
            $Folder = Get-PnPProperty -ClientObject $_ -Property RootFolder
  
            #Iterate through each document and collect data           
#            ForEach($ListItem in $ListItems)
            ForEach($ListItem in $ListItems | Where { $_.FieldValues.File_x0020_Type -eq $Ext})
            {  
                #Collect document data
                $global:DocumentInventory += New-Object PSObject -Property ([ordered]@{
                    SiteName  = $Web.Title
                    LibraryName = $List.Title
                    FileSize = [math]::Round($ListItem.FieldValues.File_x0020_Size/1KB)
                    FileName = $ListItem.FieldValues.FileLeafRef
#                    FileType = $ListItem.FieldValues.File_x0020_Type
                    ParentFolder = $Folder.ServerRelativeURL
                    SiteURL  = $Web.URL
                    AbsoluteURL = "$TenantURL$($ListItem.FieldValues.FileRef)"
                })
            }
        }
}
   
#Connect to Site collection
Connect-PnPOnline -Url $SiteURL -Interactive
     
#Call the Function for Webs
Get-PnPSubWeb -Recurse -IncludeRootWeb | ForEach-Object { Get-DocumentInventory $_ }
    
#Export Documents Inventory to CSV
$Global:DocumentInventory | Export-Csv $CSVPath -NoTypeInformation
Write-host "$Ext Files Report for $SiteURL has been Exported to '$CSVPath'" -f Green

