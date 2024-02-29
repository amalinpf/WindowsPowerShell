<#11/18/22 ajm, changes site logo for sites in .csv file $SourceCSVFilePath
From https://www.netwoven.com/2019/07/24/modifying-sharepoint-modern-site-header-layout-and-site-logo-using-pnp-powershell/
Also see: https://www.sharepointdiary.com/2019/08/sharepoint-online-change-header-layout-site-logo-background-using-powershell.html
If one doesn't change, you should manually remove it from 'Change the look'>'Header', thumbnail should be correct
#>

#Install-Module SharePointPnPPowerShellOnline -force
#Set the source csv file path
#$SourceCSVFilePath="C:\Users\amalin\OneDrive - City of Post Falls\Documents\sharepoint\Scripts\Input\SiteLogos.csv";
$SourceCSVFilePath=".\Input\SiteLogos.csv";

try
 {
  $SiteDetails = Import-CSV -path $SourceCSVFilePath -Header("SiteUrl","LogoUrl")
 }
catch [System.Exception] 
 { 
  Write-Host -ForegroundColor Red $_.Exception.ToString()
  break;
 }
Write-Host -ForegroundColor Green "Processing data from CSV file."
$RowCount=0
foreach ($row in $SiteDetails)
{
############ skip the column header in csv file
 if($RowCount -eq 0)
 {
  $RowCount=$RowCount+1
 }
 else
 {
 try
  {
   if($row.SiteUrl -ne "") 
   {
     ######## Connecting To SP Site ###############################
    $webUrl=$row.SiteUrl;
    $LogoUrl=$row.LogoUrl;
    Write-Output $("Connecting to {0}…" -f $webUrl);
    Write-Output "Logo file… $LogoUrl"
    Connect-PnPOnline -Url $webUrl -Interactive
    Write-Host -ForegroundColor Yellow "Site Connected…."
     ########## Update Header Layout and Site Logo ################
    $web = Get-PnPWeb 
    $web.SiteLogoUrl = $LogoUrl     # Set the site Logo
    $web.Update()
    Invoke-PnPQuery
    Write-Host ($RowCount) "] Header Layout and Site Logo Updated…."
    $RowCount=$RowCount+1;
   }
  }
  catch [System.Exception] 
  { 
   Write-Host -ForegroundColor Red $_.Exception.ToString() 
  }
 }
}