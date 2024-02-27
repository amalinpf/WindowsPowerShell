# getEmailActivityCounts   https://learn.microsoft.com/en-us/graph/api/reportroot-getemailactivitycounts?view=graph-rest-1.0&tabs=powershell
# also see  https://o365reports.com/2020/08/12/export-office-365-mail-traffic-report-with-powershell/

Install-Module Microsoft.Graph
Install-Module Microsoft.Graph.Reports
Import-Module Microsoft.Graph.Reports
Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"
disConnect-MgGraph
$periodId = 'D7'
$Outfile = 'c:\temp\email.txt'

Get-MgReportEmailActivityCount -Period $periodId -Outfile '$Outfile'

<# Check Policies
Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov
Get-OrganizationConfig | fl EwsApplicationAccessPolicy,EWS*List
Get-CASMailbox amalin@postfalls.gov | fl EwsApplicationAccessPolicy,EWS*List
#>
$user = Get-MgUser -Filter "displayname eq 'jerry collins'" | select *

Get-MgUser |select DisplayName, manager


Get-MailTrafficSummaryReport –Category TopMailRecipient | Select C1,C2 
Get-MailTrafficSummaryReport –Category TopMailSender | Select C1,C2 