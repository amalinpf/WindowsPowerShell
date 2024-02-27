# Prepend site titles with DEV- (optional)
$SiteUrl = "http://sharepoint-dev"
$Prefix = "DEV-"
	Connect-PnPOnline -Url $SiteURL -currentCredentials 
	$root = Get-PNPWeb	
	$OldTitle = $root.Title				# Process root web
	$NewTitle = $Prefix + $OldTitle			# There's probably a more elegant way
	write-Output "$OldTitle >>> $NewTitle"
	Set-PnPweb -title $NewTitle
$webs = Get-PnPSubWebs -recurse				# Get list of subwebs
foreach ($web in $webs) {				# Interate through them
$OldTitle = $web.title
    	$NewTitle = $Prefix + $OldTitle
	Connect-PnPOnline -Url $web.url -currentCredentials 
	write-Output "$OldTitle >>> $NewTitle"
    	Set-PnPweb -title $NewTitle
}


#to revert, replace
$NewTitle = $OldTitle.Replace($Prefix,"")



