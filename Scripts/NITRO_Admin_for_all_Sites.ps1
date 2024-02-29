# 5/31/23 ajm, Generate shortcuts to all NITRO SC Admin pages

    ###############################################   
    # Set screen size to avoid cutoff
	$buffer = $host.ui.RawUI.BufferSize; 
	$buffer.width = 3000; 
	$buffer.height = 3000; 
	$host.UI.RawUI.Set_BufferSize($buffer)
    ###############################################


$WebURL = "https://postfallsidahoorg.sharepoint.com"
$InFile = "C:\Users\amalin\OneDrive - City of Post Falls\Documents\WindowsPowerShell\Input\Site_Collections_All.csv"

Import-Csv $InFile | ForEach-Object {
	$Address = "$WebURL$($_.Site_Collection)"
	Connect-PnPOnline -Url $Address -Interactive

	$Web = Get-PnPWeb -Includes ID
	$WebID = $Web.Id.ToString()

	Write-Output "$Address/_layouts/15/appredirect.aspx?client_id=1fecf81a-a6de-47d8-97b9-f23164792f2d&redirect_uri=https%3a%2f%2fnitrostudio.azurewebSites.net%2FPages%2FNitroApps.aspx%3F%7BStandardTokens%7D%26r_webId=$WebID"
}

