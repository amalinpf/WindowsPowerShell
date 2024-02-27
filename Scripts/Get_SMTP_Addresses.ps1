$OutputFile = 'H:\Documents\WindowsPowerShell\Output\email-recipients.csv'
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName amalin@postfallsidaho.org
Get-recipient | Select-Object DisplayName,RecipientType,@{Name="EmailAddresses";Expression={$_.EmailAddresses |Where-Object {$_ -LIKE "SMTP:*"}}} |Export-Csv $OutputFile
