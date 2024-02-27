#Modify the values for the following variables to configure the audit log search.
$logFile = ".\Output\Audit.txt"
$outputFile = ".\Output\Audit.csv"
[DateTime]$start = [DateTime]::UtcNow.AddDays(-30)
[DateTime]$end = [DateTime]::UtcNow
$record = "SharePoint"
$FreeText = "postfallspolice"
$ObjectIDs = "https://postfallsidahoorg.sharepoint.com/*"
$resultSize = 5000
$intervalMinutes = 14400

#Start script
Connect-ExchangeOnline -ShowBanner:$False

[DateTime]$currentStart = $start
[DateTime]$currentEnd = $end

Function Write-LogFile ([String]$Message)
{
    $final = [DateTime]::Now.ToUniversalTime().ToString("s") + ":" + $Message
    $final | Out-File $logFile -Append
}

Write-LogFile "BEGIN: Retrieving audit records between $($start) and $($end), RecordType=$record, PageSize=$resultSize."
Write-Host "Retrieving audit records for the date range between $($start) and $($end), RecordType=$record, ResultsSize=$resultSize"

$totalCount = 0
while ($true)
{
    $currentEnd = $currentStart.AddMinutes($intervalMinutes)
    if ($currentEnd -gt $end)
    {
        $currentEnd = $end
    }

    if ($currentStart -eq $currentEnd)
    {
        break
    }

    $sessionID = [Guid]::NewGuid().ToString() + "_" +  "ExtractLogs" + (Get-Date).ToString("yyyyMMddHHmmssfff")
    Write-LogFile "INFO: Retrieving audit records for activities performed between $($currentStart) and $($currentEnd)"
    Write-Host "Retrieving audit records for activities performed between $($currentStart) and $($currentEnd)"
    $currentCount = 0

    $sw = [Diagnostics.StopWatch]::StartNew()
    do
    {
        $results = Search-UnifiedAuditLog -StartDate $currentStart -EndDate $currentEnd -RecordType $record -SessionId $sessionID -SessionCommand ReturnLargeSet -ResultSize $resultSize -FreeText $FreeText -ObjectIDs $ObjectIDs

        if (($results | Measure-Object).Count -ne 0)
        {
            $results.AuditData | ConvertFrom-Json | select CreationTime, UserID, Operation, ObjectID | export-csv -Path $outputFile -Append -NoTypeInformation

            $currentTotal = $results[0].ResultCount
            $totalCount += $results.Count
            $currentCount += $results.Count
            Write-LogFile "INFO: Retrieved $($currentCount) audit records out of the total $($currentTotal)"

            if ($currentTotal -eq $results[$results.Count - 1].ResultIndex)
            {
                $message = "INFO: Successfully retrieved $($currentTotal) audit records for the current time range. Moving on!"
                Write-LogFile $message
                Write-Host "Successfully retrieved $($currentTotal) audit records for the current time range. Moving on to the next interval." -foregroundColor Yellow
                ""
                break
            }
        }
    }
    while (($results | Measure-Object).Count -ne 0)

    $currentStart = $currentEnd
}

Write-LogFile "END: Retrieving audit records between $($start) and $($end), RecordType=$record, PageSize=$resultSize, total count: $totalCount."
Write-Host "Script complete! Finished retrieving audit records for the date range between $($start) and $($end). Total count: $totalCount" -foregroundColor Green

<# Shorter, but might drop some records if date range too long

Connect to Exchange Online
$OutFile = ".\Output\AuditSPDiary.csv"       # or .txt
$Record = "SharePoint"
$FreeText = "postfallspolice"
$ObjectIDs = "https://postfallsidahoorg.sharepoint.com/*"

Connect-ExchangeOnline -ShowBanner:$False
 
#Set Dates
$StartDate = (Get-Date).AddDays(-30)
$EndDate = (Get-Date)
 
#Search Unified Log
$AuditLog = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -ResultSize 5000  -FreeText $FreeText -RecordType $Record  -ObjectIDs $ObjectIDs
$AuditLogResults = $AuditLog.AuditData | ConvertFrom-Json | select CreationTime, UserID, Operation, ObjectID
$AuditLogResults
$AuditLogResults | Export-csv -Path $OutFile -NoTypeInformation
 
#Disconnect Exchange Online

 #>