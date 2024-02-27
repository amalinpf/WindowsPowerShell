$TestURL = "https://postfallsidahoorg.sharepoint.com/sites/test2"
    Connect-PnPOnline -Url $TestURL -Interactive
    $Web = Get-PnPWeb
  #  Get-PnPRecycleBinItem | Select-Object Id, DirName, Title, Size, DeletedDate, ItemType, ItemState, DeletedByName | export-csv $OutFile
   
    #Get the Site Title
    Write-host -f Green $Web.Title    
