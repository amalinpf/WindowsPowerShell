10/5/20 - Restore Production Content DB to TEST https://sharepoint.stackexchange.com/questions/198814/restore-production-content-db-to-test

use this PowerShell cmdlet to retrieve all content databases of a particular web application:
Get-SPContentDatabase -Site https://inet.postfallsidaho.org
