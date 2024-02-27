# https://github.com/Mike-Crowley/Public-Scripts/blob/main/MailUser-MgUser-Activity-Report.ps1

<# 
disconnect-ExchangeOnline 
disconnect-MgGraph
#>

Connect-ExchangeOnline -UserPrincipalName amalin@postfalls.gov
Connect-MgGraph -TenantId f5eede05-2f08-4d8e-8bff-5c78a3dd2dd3
#Select-MgProfile #beta

$MailUsers = Get-MailUser -filter {recipienttypedetails -eq 'MailUser'} -ResultSize unlimited
$ReportUsers = $MailUsers | ForEach-Object {
    $MailUser = $_   
    
    $Counter ++
#    $percentComplete = (($Counter / $MailUsers.count) * 100)
#    Write-Progress -Activity "Getting MG Objects" -PercentComplete $percentComplete -Status "$percentComplete% Complete:"    
       
       #to do - organize properties better
 #      Get-MgUser -UserId $MailUser.ExternalDirectoryObjectId -ConsistencyLevel eventual -Property @(
        Get-MgUser -UserId $MailUser.ExternalDirectoryObjectId  -Property @(
            'UserPrincipalName'
        'SignInActivity'
        'CreatedDateTime'        
        'DisplayName'
        'Mail'
        'OnPremisesImmutableId'
        'OnPremisesDistinguishedName'
        'OnPremisesLastSyncDateTime'
        'SignInSessionsValidFromDateTime'
        'RefreshTokensValidFromDateTime'
        'id'
    ) | Select-Object @(
        'UserPrincipalName'        
        'CreatedDateTime'        
        'DisplayName'
        'Mail'
        'OnPremisesImmutableId'
        'OnPremisesDistinguishedName'
        'OnPremisesLastSyncDateTime'
        'SignInSessionsValidFromDateTime'
        'RefreshTokensValidFromDateTime'
        'id'        
        @{n='PrimarySmtpAddress'; e={$MailUser.PrimarySmtpAddress}}
        @{n='ExternalEmailAddress'; e={$MailUser.ExternalEmailAddress}}
        @{n='LastSignInDateTime'; e={[datetime]$_.SignInActivity.LastSignInDateTime}}
        @{n='lastNonInteractiveSignInDateTime'; e={[datetime]$_.SignInActivity.AdditionalProperties.lastNonInteractiveSignInDateTime}}           
    )
}

$Common_ExportExcelParams = @{
    # PassThru     = $true
    BoldTopRow   = $true
    AutoSize     = $true
    AutoFilter   = $true
    FreezeTopRow = $true
}

$FileDate = Get-Date -Format yyyyMMddTHHmmss

$ReportUsers | Sort-Object UserPrincipalName | Export-Excel @Common_ExportExcelParams -Path (".\output\" + $filedate + "_report.xlsx") -WorksheetName report

<# 
###############################################################
 #>
 
