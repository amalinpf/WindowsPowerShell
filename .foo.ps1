##### SCRIPT

$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/Shared"
$ListName ="Z_Drive_Migration"
$FolderServerRelativeURL = "/sites/Shared"
write-host "Starting, list: "$ListName
Try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -Interactive
       
    #Get All Items from Folder in Batch
    $ListItems = Get-PnPListItem -List $ListName -FolderServerRelativeUrl $FolderServerRelativeURL -PageSize 2000 | Sort-Object ID -Descending
   
    #Powershell to delete all files from a folder
    ForEach ($Item in $ListItems)
    {
        Remove-PnPListItem -List $ListName -Identity $Item.Id -Recycle -Force
        Write-host "Removed File:"$Item.FieldValues.FileRef
    }
}
Catch {
    write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}
