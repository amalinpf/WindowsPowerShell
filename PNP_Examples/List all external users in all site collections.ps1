$AdminSiteURL = 'https://postfallsidahoorg-admin.sharepoint.com'
$AdminSite = $AdminSiteURL
$AdminURL = $AdminSiteURL
$TenantURL = 'https://postfallsidahoorg.sharepoint.com'
$dateTime = '_{0:MM_dd_yy}_{0:HH_mm_ss}' -f (Get-Date)
$basePath = '.\Output'
$CSVPath = $BasePath + "\ExternalUsers" + $DateTime + ".csv"
$global:ExternalUsersData = @() 
Function LoginToAdminSite() {
    Write-Host "Connecting to Tenant Admin Site '$($AdminURL)'..." -ForegroundColor Yellow
    Connect-PnPOnline -Url $AdminURL -Interactive
    Write-Host "Connection Successfull to Tenant Admin Site :'$($AdminURL)'" -ForegroundColor Green
}
Function ConnectToSPSite() {
    try {
        $SiteCollection = Get-PnPTenantSite -Filter "Url -like '$TenantURL'" | Where { $_.SharingCapability -ne "Disabled" }
        foreach ($Site in $SiteCollection) {
            $SiteUrl = $Site.Url    
            Write-Host "Connecting to Site :'$($SiteUrl)'..." -ForegroundColor Yellow  
            Connect-PnPOnline -Url $SiteUrl -Interactive
            Write-Host "Connection Successfull to site: '$($SiteUrl)'" -ForegroundColor Green              
            GetExternalUsers($SiteUrl)                        
        }
        ExportData       
    }
    catch {
        Write-Host "Error in connecting to Site:'$($SiteUrl)'" $_.Exception.Message -ForegroundColor Red               
    } 
}
Function GetExternalUsers($siteUrl) {
    try {
        $ExternalUsers = Get-PnPUser | Where { $_.LoginName -like "*#ext#*" -or $_.LoginName -like "*urn:spo:guest*" }   
        Write-host "Found '$($ExternalUsers.count)' External users" -ForegroundColor Gray
        ForEach ($User in $ExternalUsers) {
            $global:ExternalUsersData += New-Object PSObject -Property ([ordered]@{
                    SiteName  = $site.Title
                    SiteURL   = $SiteUrl
                    UserName  = $User.Title
                    Email     = $User.Email
                    LoginName = $User.LoginName
                })
        }          
    }
    catch {
        Write-Host "Error in getting external users :'$($siteUrl)'" $_.Exception.Message -ForegroundColor Red                 
    }        
}

Function ExportData {
    Write-Host "Exporting to CSV" -ForegroundColor Yellow           
    $global:ExternalUsersData | Export-Csv -Path $CSVPath -NoTypeInformation -Append
    Write-Host "Exported Successfully!" -ForegroundColor Green 
}

Function StartProcessing {   
    LoginToAdminSite($AdminURL) 
    ConnectToSPSite
}

StartProcessing

