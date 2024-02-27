$farm=Get-SPFarm
#$farm.Properties.Add("NITROWFDebugSessionSite", "https://portal.sharepoint-dev.postfallscity.com/cityhallit")
#If exists: 
$farm.Properties["NITROWFDebugSessionSite"] = "https://portal.sharepoint-dev.postfallscity.com";
#$farm.Properties["NITROWebAPIURL"] = "http://sharepoint-dev:40000/api/rest";
$farm.Update()

