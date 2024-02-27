<#
1/26/22 ajm, Finds where audiences are used
 from https://spsawyer.wordpress.com/2013/03/08/programmatically-find-audience-usage/
#>

#$WebApplicationURL = 'https://inet.postfallsidaho.org/'
$WebApplicationURL = 'https://portal.sharepoint-dev.postfallscity.com/'

<# 
Param(
	[parameter(Mandatory=$True,Position=1)]
	[String]
		$WebApplicationURL
)

if((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction
SilentlyContinue) -eq $null){
    $ver = $host | select version
    if ($ver.Version.Major -gt 1) {
        $Host.Runspace.ThreadOptions = "ReuseThread"
    }
    Add-PsSnapin Microsoft.SharePoint.PowerShell
    Set-location $home
}
 #>
$psShared = [System.Web.UI.WebControls.WebParts.PersonalizationScope]::Shared;

$allSites = Get-SPWebApplication $WebApplicationURL | Get-SPSite -Limit ALL;

[Void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server.Audience");
$spcontext = [Microsoft.Office.Server.ServerContext]::GetContext($allSites[0]);
$audmanager = New-Object Microsoft.Office.Server.Audience.AudienceManager($spcontext);
$audiences = $audmanager.Audiences;

function GetAudienceNames([string]$audienceFilter){
    $au = $audienceFilter.Split(";;");
    if($au[0] -ne "") {
        $au[0].Split(',') | foreach-object { 
            if($audiences.AudienceExist([Guid]$_)) {
                $audienceFilter = $audienceFilter.Replace($_, $audiences[[Guid]$_].AudienceName); # $r += $audiences[[Guid]$_].AudienceName + ", ";
            }
        }
    }
    return $audienceFilter.Replace(";;","|");
}

function GetLWPM($w, [string]$url){
    try {
        $wpm = $w.GetLimitedWebPartManager($url, $psShared);
    }
    catch {
        write-host ("Error getting limited web part manager for " + $url) -foreground red
    }
    return $wpm;
}

write-output ("Web|Path|Web Part Title|SharePoint Audience|Audience AD LDAP Path|SharePoint Group");

$allSites | get-spweb -limit all | foreach-object {
	$w = $_;
    try {
	$w.Files | where-object {$_.ServerRelativeUrl -like "*.aspx"} | foreach-object {
		$wpm = GetLWPM -w $w -url $_.ServerRelativeUrl; #$w.GetLimitedWebPartManager($_.ServerRelativeUrl, $psShared);
        if($wpm){
            try{
		      $wpm.WebParts | where-object {$_.AuthorizationFilter -gt ""} | foreach-object {
		          write-output ($w.Url + "|" + $_.ServerRelativeUrl + "|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_.AuthorizationFilter));
		      }
            } finally {
                $wpm.Dispose();
            }
        }
	}
	$w.Lists | where-object { !$_.Hidden } | foreach-object {
        if($_ -is [Microsoft.SharePoint.SPDocumentLibrary]){
    		$_.Items | where-object {$_.Url -like "*.aspx"} | foreach-object {
                $item = $_;
                $iUrl = ($w.Url + "/" + [System.Web.HttpUtility]::UrlPathEncode($_.Url));
    			$wpm = GetLWPM -w $w -url $iUrl; # $w.GetLimitedWebPartManager($iUrl, $psShared);
                if($wpm){
                  try{
    			    $wpm.WebParts | where-object {$_.AuthorizationFilter -gt ""} | foreach-object {
    			 	   write-output ($w.Url + "|" + $item.Url + "|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_.AuthorizationFilter));
    			    }
                  } finally {
                    $wpm.Dispose();
                  }
                }
            }
        }
        if ($_.Fields.ContainsFieldWithStaticName("Target_x0020_Audiences")) {
            $_.Items | foreach-object {
                if ($_["Target_x0020_Audiences"] -ne $null){
                    write-output ($w.Url + "|" + $_.Url + "|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_["Target_x0020_Audiences"]));
                }
            }
        }
	}
    if([Microsoft.SharePoint.Publishing.PublishingWeb]::IsPublishingWeb($w)){
        $pweb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($w);
        $pweb.Navigation.GlobalNavigationNodes | where-object { $_.Properties.ContainsKey("Audience") -and $_.Properties["Audience"] -ne "" } | foreach-object { 
            write-output ($w.Url + "|[GlobalNavigationNodes]|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_.Properties["Audience"]))
        }
        $pweb.Navigation.CurrentNavigationNodes | where-object { $_.Properties.ContainsKey("Audience") -and $_.Properties["Audience"] -ne "" } | foreach-object { 
            write-output ($w.Url + "|[CurrentNavigationNodes]|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_.Properties["Audience"]))
        }
    } else {
        $w.Navigation.QuickLaunch | where-object { $_.Properties.ContainsKey("Audience") -and $_.Properties["Audience"] -ne "" } | foreach-object { 
            write-output ($w.Url + "|[QuickLaunch]|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_.Properties["Audience"]))
        }
        $w.Navigation.TopNavigationBar | where-object { $_.Properties.ContainsKey("Audience") -and $_.Properties["Audience"] -ne "" } | foreach-object { 
            write-output ($w.Url + "|[TopNavigationBar]|" + $_.Title + "|" + (GetAudienceNames -audienceFilter $_.Properties["Audience"]))
        }
    }
    } finally {
        $w.Dispose();
    }
}
