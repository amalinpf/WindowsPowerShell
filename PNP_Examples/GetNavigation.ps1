$AdminSite = 'https://postfallsidahoorg-admin.sharepoint.com'
$dateTime = '_{0:MM_dd_yy}_{0:HH_mm_ss}' -f (Get-Date)
$basePath = '.\Output'
$csvPath = $basePath + '\RootNavigation' + $dateTime + '.csv'


Connect-PnPOnline -Url $AdminSite -Interactive

# Get all main sites in the hub
$hubSiteUrl = "https://postfallsidahoorg.sharepoint.com/"
$mainSites = Get-PnPHubSiteChild -Identity $hubSiteUrl

# Initialize an array to hold the results
$myResults = @()

foreach ($site in $mainSites) {
    # Switch context to the main site
    Connect-PnPOnline -Url $site -UseWebLogin

    # Get top-level navigation nodes
    $navNodes = Get-PnPNavigationNode # -Location TopNavigationBar

    foreach ($node in $navNodes) {
        # Add parent node to results
        $myResults += [PSCustomObject]@{
            NodeCode = $node.Id
            NodeTitle = $node.Title
            NodeType = "Parent"
            URL      = $node.Url
        }

        # Get child nodes
        $childNodes = Get-PnPNavigationNode -Id $node.Id

        foreach ($childNode in $childNodes.Children) {

            # Check if the child node title is "Confluence" and change it to "Confluence2"
            if ($childNode.Title -eq "Confluence") {
                # Rename the child node to "Confluence2"
                  $childNode.Title = "Confluence2"
                  $childNode.Url = "/Lists/TestLlist"
                  $childNode.Update()
                  $childNode.Context.ExecuteQuery()
               
                $childNode.Title = "Confluence2" # Update local object for display
            }

            # Add child nodes to results
            $myResults += [PSCustomObject]@{
                NodeCode = $childNode.Id
                NodeTitle = $childNode.Title
                NodeType = "Child"
                URL      = $childNode.Url
            }
        }
    }

    Disconnect-PnPOnline
}

$myResults | Export-Csv $csvPath -NoTypeInformation -Append