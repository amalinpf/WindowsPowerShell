<# 
How to change Modified Display Format to Standard view for all site/subsite in SharePoint Online?
https://docs.microsoft.com/en-us/answers/questions/590762/how-to-change-modified-display-format-to-standard.html

 #>

#Set Variables
 $SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment"
               Connect-PnPOnline -Url $SiteURL -interactive
                 $Lists = Get-PnPList | Where {$_.Hidden -eq $false -and $_.Title -ne 'Style Library'}
                 ForEach($list in $Lists){
                 Write-host -F White $list.Title
                 #Disable the modified column friendlyformat
                 Set-PnPField -List $list -Identity "Modified" -Values @{FriendlyDisplayFormat=1}     
                 Set-PnPField -List $list -Identity "Created" -Values @{FriendlyDisplayFormat=1}     
             }
			 
