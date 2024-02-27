#Convert SharePoint view to Personal and vice versa
$SiteURL = 'https://postfallsidahoorg.sharepoint.com/sites/FinanceDepartment'
$List = 'Budget Requests'
$View = 'Arts'
$PersonalView = '-Personal'	#Comment line to make Public view

Connect-PnPOnline -Url $SiteURL -interactive   

#get all fields in Original view
$Fields = Get-PnPview -List $List -Identity $View  
$query = Get-PnPProperty -ClientObject $Fields -Property ViewQuery		# Use this to populate properties not initially available
$arrayFields = foreach($Field in $Fields.viewFields) {$Field}
$strFields = '"' + ($arrayFields -join '","') + '"'

#Get rid of original
Remove-PnPView -List $List -Identity $View -force

<# 
#Rereate view 	DOESN'T WORK, USE SCRIPT OUTPUT BELOW TO ADD BACK
Add-PnPView -Fields $strFields -List '$List' -Title '$View' -query '$query'
 #>
 
#GENERATE SCRIPT to create view later:
$buffer = $host.ui.RawUI.BufferSize; 
$buffer.width = 3000; 
$host.UI.RawUI.Set_BufferSize($buffer)

write-output ""
write-output "###################################################################################"
write-output "##################### Execute command below to create view ########################"
write-output "###################################################################################"
write-output ""
write-output "Add-PnPView -Fields $strFields -List '$List' -Title '$view' -query '$query' $PersonalView"
write-output ""
write-output "###################################################################################"
write-output ""

