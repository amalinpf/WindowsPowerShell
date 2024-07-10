$SiteURL = "https://postfallsidahoorg.sharepoint.com"  # Might need Admin sometimes
Connect-PnPOnline $SiteURL -Interactive     # Connect to site

Get-PnPSearchSettings     # Tenant top-level search settings

Set-PnPSearchSettings -SearchScope Tenant
Set-PnPSearchSettings -SearchScope DefaultScope
# DefaultScope | Hub | Site | Tenant
Set-PnPSearchSettings -Scope Web -SearchBoxPlaceholderText "Search Everything"

