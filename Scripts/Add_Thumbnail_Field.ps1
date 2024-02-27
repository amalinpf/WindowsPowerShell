$SiteURL="https://postfallsidahoorg.sharepoint.com/sites/CDSpecialProjects"
$List = "Site Assets"
$FieldTitle = "Thumbnail"
Connect-PnPOnline -Url $SiteURL -Interactive

$exists = Get-PnPField -List $List -Identity $FieldTitle -ErrorAction SilentlyContinue	#Only add if doesn't exist

if($exists -eq $null)
	{
    Write-host "Field '$FieldTitle' does not exists in the list '$List', adding it" -f Yellow
	Add-PnPField -List $List -Type URL -DisplayName $FieldTitle -InternalName $FieldTitle -AddToDefaultView 
	}
else
	{
    Write-host "Field '$FieldTitle' exists in the list '$List', dont add" -f Red
	}
