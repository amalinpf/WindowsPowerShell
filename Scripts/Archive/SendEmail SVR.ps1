$sdo = new-object System.collections.specialized.stringdictionary
$sdo.add("to","amalin@postfallsidaho.org")
$sdo.add("from","sp_notice@postfallsidaho.org")
$sdo.add("Subject","Test message from SharePoint 2019")
$web = get-spweb "https://inet.postfallsidaho.org/"
$messagebody = "This is a test message from SharePoint-svr on-prem using PowerShell"
[Microsoft.SharePoint.Utilities.SPUtility]::SendEmail($web,$sdo,$messagebody)

