$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/CityClerkDepartment"
$ReportOutput ="C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\Scripts\Output\ContentTypeUsage.csv"
$ContentTypeName="Temp"
 
#Delete the Output Report, if exists
If (Test-Path $ReportOutput) { Remove-Item $ReportOutput }
 
Try{
    #Connect to the Site        
    Connect-PnPOnline -Url $SiteURL -Interactive
 
    #Get All Lists
    $Lists = Get-PnPList -Includes RootFolder | Where-Object {$_.Hidden -eq $False}
     
    #Get content types of each list from the web
    $ContentTypeUsages=@()
    ForEach($List in $Lists)
    {
        Write-host -f Yellow "Scanning List:" $List.Title
        $ListURL =  $List.RootFolder.ServerRelativeUrl
 
        #get all content types from the list
        $ContentType = Get-PnPContentType -List $List | Where {$_.Name -eq $ContentTypeName}
   
        #Collect list details
        If($ContentType)
        {
            $ContentTypeUsage = New-Object PSObject
            $ContentTypeUsage | Add-Member NoteProperty SiteURL($SiteURL)
            $ContentTypeUsage | Add-Member NoteProperty ListName($List.Title)
            $ContentTypeUsage | Add-Member NoteProperty ListURL($ListURL)
            $ContentTypeUsage | Add-Member NoteProperty ContentTypeName($ContentType.Name)
            Write-host -f Green "`tFound the Content Type in Use!"
 
            #Export the result to CSV file
            $ContentTypeUsage | Export-CSV $ReportOutput -NoTypeInformation -Append
        }
    }
}
Catch {
    write-host -f Red "Error Generating Content Type Usage Report!" $_.Exception.Message
}
