 
# COPIES TEMPLATE ....needs cleanup!

$DstSite = "/sites/TestHub2/ittesting"
$SrcSite = "/sites/CityHallITDept"
$SrcURL = "https://postfallsidahoorg.sharepoint.com$SrcSite"
$DstURL = "https://postfallsidahoorg.sharepoint.com$DstSite"
$TmplName = "Helpful_SP_URLs"
$SrcLib = "Lists/Helpful_SP_URLs"
$DstLib = "Lists/Helpful_SP_URLs"
$SrcTmplURL = $SrcSite+"/_catalogs/lt/"+$TmplName+".stp"
$DstTmplURL = $DstSite+"/_catalogs/lt"

    #Connect to the Source Site
    $SourceConn = Connect-PnPOnline -URL $SrcURL -Interactive -ReturnConnection
    $SourceCtx = $SourceConn.Context
   
     #Connect to the Destination Site
    $DestinationConn = Connect-PnPOnline -URL $DstURL -Interactive -ReturnConnection
    $DestinationCtx = $DestinationConn.Context

 
   
   
    #Copy List Template from source to the destination site
    Write-host "Copying List Template from Source to Destination Site..." -f Yellow -NoNewline
    Write-host "Copy-PnPFile -SourceUrl $SrcTmplURL -TargetUrl $DstTmplURL -Force -OverwriteIfAlreadyExists -Connection $SourceConn"


	Copy-PnPFile -SourceUrl $SrcTmplURL -TargetUrl $DstTmplURL -Force -Connection $SourceConn


    Write-host "Done!" -f Green
   
 <#    #Reload List Templates to Get Newly created List Template
    $DestinationListTemplates = $DestinationCtx.Site.GetCustomListTemplates($DestinationRootWeb)
    $DestinationCtx.Load($DestinationListTemplates)
    $DestinationCtx.ExecuteQuery()
    $DestinationListTemplate = $DestinationListTemplates | Where {$_.Name -eq $TmplName}
 
    #Create the destination library from the list template
    Write-host "Creating New Library in the Destination Site..." -f Yellow -NoNewline
    If(!(Get-PnPList -Identity $DstLib -Connection $DestinationConn))
    {
        #Create the destination library
        $ListCreation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $ListCreation.Title = $TmplName
        $ListCreation.ListTemplate = $DestinationListTemplate
        $DestinationList = $DestinationCtx.Web.Lists.Add($ListCreation)
        $DestinationCtx.ExecuteQuery()
        Write-host "Library '$TmplName' created successfully!" -f Green
    }
    Else
    {
        Write-host "Library '$DstLib' already exists!" -f Yellow
    }
 #>    

<# Copy-PnPFile -SourceUrl /sites/CityHallITDept/_catalogs/lt/Helpful_SP_URLs.stp -TargetUrl /sites/LegalDepartment/_catalogs/lt -Force -OverwriteIfAlreadyExists -Connection $SourceConn
						/sites/CityHallITDept/_catalogs/lt/Helpful_SP_URLs.stp			  /sites/LegalDepartment/_catalogs/lt/

$SrcTmplURL
/sites/CityHallITDept/_catalogs/lt/Helpful_SP_URLs.stp

$DstTmplURL
/sites/LegalDepartment/_catalogs/lt/
 #>

