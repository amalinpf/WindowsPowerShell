# scratch file
# ADD LOOP THROUGH ALL SC AND SITES

$Url = "https://postfallsidahoorg.sharepoint.com/sites/HRDept"

$Url
Connect-PnPOnline –Url $Url -interactive

$web = Get-PnPWeb –Includes AppTiles

$appTiles = $web.AppTiles
Invoke-PnPQuery

foreach ($appTile in $appTiles)
{
    $appTitle = $appTile.AppTitle
    $appType = $appTile.AppType
    $appStatus = $appTile.AppStatus
    $appSource = $appTile.AppSource
    $isCorporateCatalogSite = $appTile.IsCorporateCatalogSite

    if ($appType -eq "Instance")
    {
        $appTile  | select Title, LastModified
    }
}