#Get users

$OutFile = ".\Output\PD_Users.csv"
$AdminSiteURL="https://postfallsidahoorg-admin.sharepoint.com/"
Connect-PnPOnline -Url $AdminSiteURL -Interactive
Connect-Msolservice -Credential $Cred

#get-msoluser |select * |export-csv $OutFile     #All Data
get-msoluser | Where {$_.UserPrincipalName -Like "*postfallspolice*"} |select UserPrincipalName, DisplayName, FirstName, LastName, Department |export-csv $OutFile #Selected fields

<# 
#Update users, modify output from above
$InFile = ".\Input\UpdateUsers.csv"
Import-Csv -path $InFile | foreach {Set-MsolUser -UserPrincipalName $_.UserPrincipalName -DisplayName $_.DisplayName -FirstName $_.FirstName -LastName $_.LastName -Department $_.Department }
#>