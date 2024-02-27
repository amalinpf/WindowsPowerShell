$sdo = new-object System.collections.specialized.stringdictionary
$sdo.add("to","amalin@postfallsidaho.org")
$sdo.add("from","sp_notice@postfallsidaho.org")
$sdo.add("Subject","Test message from SharePoint")
$web = get-spweb "https://sharepoint-dev/"
$messagebody = "This is a test message from SharePoint-dev on-prem using PowerShell"
[Microsoft.SharePoint.Utilities.SPUtility]::SendEmail($web,$sdo,$messagebody)
