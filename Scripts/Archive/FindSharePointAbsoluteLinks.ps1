Add-PSSnapin Microsoft.sharepoint.powershell -ErrorAction SilentlyContinue

#GET WEB APPLICATION
$webApp = Get-SPWebApplication http://sharepoint-dev
#URL SEARCH STRING FOR ABSOLUTE URL
$searchURL = "*http*"
$outCSVfile = "C:\Users\amalin\Documents\SharePoint\Scripts\Output\Hyperlinks.csv"

#CREATE .CSV FILE WITH HEADINGS FOR HYPERLINKS
"siteURL `t" + "Heading `t" + "hyperlink `t" + "Path" >> $outCSVfile

#FOREACH LOOP - LOOPS THROUGH ALL WEBS AND SUBSITES OF WEB APPLICATION
foreach ($web in $webApp | Get-SPSite -Limit All | Get-SPWeb -Limit All)
{
#GET PUBLISHING WEB FOR ALL WEBS IN WEB APPLICATION
$pubWeb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($web)
#GET GLOBAL NAVIGATION NODES
$nav = $pubWeb.Navigation.GlobalNavigationNodes
#GET QUICK LAUNCH NAVIGATION NODES
$nodes = $web.Navigation.QuickLaunch

#FOREACH LOOP - LOOPS THROUGH ALL GLOBAL NAVIGATION HEADINGS.
foreach ($qlHeading in $nav)
{
#GET GLOBAL NAVIGATION HEADING CHILDREN.
$qlLibraries = $qlHeading.Children

#FOREACH LOOP - LOOPS THROUGH ALL CHILDREN (LINKS) IN GLOBAL NAVIGATION HEADINGS.
foreach ($lib in $qlLibraries)
{
#IF STATEMENT TO CHECK IF HYPERLINK IS NOT NULL.
if ($lib.Url -ne $null)
{
write-host $qlHeading.Title
write-host $lib.Url
#IF STATEMENT TO CHECK HYPERLINK TO SEE IF IT MATCHES searchURL string.
if ($lib.Url -like $searchURL)
{
#IF HYPERLINK MATCHES THE $searchURL STRING THEN STORE "AbsoluteURL" STRING IN $path VARIABLE.
$path = "AbsoluteURL"
}
else
#IF HYPERLINK DOES NOT MATCH THE $searchURL  STRING THEN STORE "RelativeURL" STRING IN $path VARIABLE.
{
$path = "RelativeURL"
}
#WRITE GLOBAL NAVIGATION NODE RESULTS TO $outCSVfile FILE.
$web.Url + "`t" + $qlHeading.Title + "`t" + $lib.Url + "`t" + $path >> $outCSVfile
}
}
}
#FOREACH LOOP - LOOPS THROUGH ALL QUICK LAUNCH NAVIGATION NODES
foreach ($node in $nodes)
{
write-host $node.Title
write-host $node.Url
#IF STATEMENT TO CHECK HYPERLINK TO SEE IF IT MATCHES searchURL string.
if ($node.Url -like $searchURL)
{
#IF HYPERLINK MATCHES THE $searchURL STRING THEN STORE "AbsoluteURL" STRING IN $path VARIABLE.
$path = "AbsoluteURL"
}
else
{
#IF HYPERLINK DOES NOT MATCH THE $searchURL  STRING THEN STORE "RelativeURL" STRING IN $path VARIABLE.
$path = "RelativeURL"
}
#WRITE QUICK LAUNCH NAVIGATION NODE RESULTS TO $outCSVfile FILE.
$web.Url + "`t" + $qlHeading.Title + "`t" + $lib.Url + "`t" + $path >> $outCSVfile
}
}