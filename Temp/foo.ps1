$AdminSiteURL = "https://postfallsidahoorg-admin.sharepoint.com"
Connect-PnPOnline $AdminSiteURL -Interactive     # Connect to Tenant Admin
Get-PnPHubSite     #List all hub sites

