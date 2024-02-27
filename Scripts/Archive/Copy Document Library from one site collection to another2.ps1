#Function to Copy library to another site
Function Copy-PnPLibrary
{
    param (
    [parameter(Mandatory=$true, ValueFromPipeline=$true)][string]$SourceSiteURL,
    [parameter(Mandatory=$true, ValueFromPipeline=$true)][string]$DestinationSiteURL,
    [parameter(Mandatory=$true, ValueFromPipeline=$true)][string]$SourceLibraryName,
    [parameter(Mandatory=$true, ValueFromPipeline=$true)][string]$DestinationLibraryName
    )
 
    Try {
    #Connect to the Source Site
    $SourceConn = Connect-PnPOnline -URL $SourceSiteURL -UseWebLogin -ReturnConnection
    $SourceCtx = $SourceConn.Context
 
    #Get the Source library
    $SourceLibrary =  Get-PnPList -Identity $SourceLibraryName -Includes RootFolder -Connection $SourceConn
 
    #Get the List Template
    $SourceRootWeb = $SourceCtx.Site.RootWeb
    $SourceListTemplates = $SourceCtx.Site.GetCustomListTemplates($SourceRootWeb)
    $SourceCtx.Load($SourceRootWeb)
    $SourceCtx.Load($SourceListTemplates)
    $SourceCtx.ExecuteQuery()
    $SourceListTemplate = $SourceListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
    $SourceListTemplateURL = $SourceRootWeb.ServerRelativeUrl+"/_catalogs/lt/"+$SourceLibrary.id.Guid+".stp"
    write-output "$SourceRootWeb.ServerRelativeUrl'/_catalogs/lt/'$SourceLibrary.id.Guid'.stp'"

 
    #Remove the List template if exists    
    If($SourceListTemplate)
    {
        Remove-PnPFile -ServerRelativeUrl $SourceListTemplateURL -Recycle -Force -Connection $SourceConn
    }
    Write-host "Creating List Template from Source Library..." -f Yellow -NoNewline
    $SourceLibrary.SaveAsTemplate($SourceLibrary.id.Guid, $SourceLibrary.id.Guid, [string]::Empty, $False)
    $SourceCtx.ExecuteQuery()
    Write-host "Done!" -f Green
 
    #Reload List Templates to Get Newly created List Template
    $SourceListTemplates = $SourceCtx.Site.GetCustomListTemplates($SourceRootWeb)
    $SourceCtx.Load($SourceListTemplates)
    $SourceCtx.ExecuteQuery()
    $SourceListTemplate = $SourceListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
     
 
    #Connect to the Destination Site
    $DestinationConn = Connect-PnPOnline -URL $DestinationSiteURL -ReturnConnection
    $DestinationCtx = $DestinationConn.Context
    $DestinationRootWeb = $DestinationCtx.Site.RootWeb
    $DestinationListTemplates = $DestinationCtx.Site.GetCustomListTemplates($DestinationRootWeb)
    $DestinationCtx.Load($DestinationRootWeb)
    $DestinationCtx.Load($DestinationListTemplates)
    $DestinationCtx.ExecuteQuery()    
    $DestinationListTemplate = $DestinationListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
    $DestinationListTemplateURL = $DestinationRootWeb.ServerRelativeUrl+"/_catalogs/lt/"+$SourceLibrary.id.Guid+".stp"
 
    #Remove the List template if exists    
    If($DestinationListTemplate)
    {
        Remove-PnPFile -ServerRelativeUrl $DestinationListTemplateURL -Recycle -Force -Connection $DestinationConn
    }
 
    #Copy List Template from source to the destination site
    Write-host "Copying List Template from Source to Destination Site..." -f Yellow -NoNewline
    Copy-PnPFile -SourceUrl $SourceListTemplateURL -TargetUrl $DestinationListTemplateURL -Force -OverwriteIfAlreadyExists
    Write-host "Done!" -f Green
 
    #Reload List Templates to Get Newly created List Template
    $DestinationListTemplates = $DestinationCtx.Site.GetCustomListTemplates($DestinationRootWeb)
    $DestinationCtx.Load($DestinationListTemplates)
    $DestinationCtx.ExecuteQuery()
    $DestinationListTemplate = $DestinationListTemplates | Where {$_.Name -eq $SourceLibrary.id.Guid}
 
    #Create the destination library from the list template
    Write-host "Creating New Library in the Destination Site..." -f Yellow -NoNewline
    If(!(Get-PnPList -Identity $DestinationLibraryName -Connection $DestinationConn))
    {
        #Create the destination library
        $ListCreation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $ListCreation.Title = $DestinationLibraryName
        $ListCreation.ListTemplate = $DestinationListTemplate
        $DestinationList = $DestinationCtx.Web.Lists.Add($ListCreation)
        $DestinationCtx.ExecuteQuery()
        Write-host "Library '$DestinationLibraryName' created successfully!" -f Green
    }
    Else
    {
        Write-host "Library '$DestinationLibraryName' already exists!" -f Yellow
    }
     
    #Copy content from Source to the destination library
    $SourceLibraryURL = $SourceLibrary.RootFolder.ServerRelativeUrl
    $DestinationLibrary = Get-PnPList $DestinationLibraryName -Includes RootFolder -Connection $DestinationConn
    $DestinationLibraryURL = $DestinationLibrary.RootFolder.ServerRelativeUrl
    Write-host "Copying Content from $SourceLibraryURL to $DestinationLibraryURL..." -f Yellow -NoNewline
 
    #Copy All Content from Source Library to the Destination Library
    Copy-PnPFile -SourceUrl $SourceLibraryURL -TargetUrl $DestinationLibraryURL -Force -OverwriteIfAlreadyExists
    Write-host "`tcontent Copied Successfully!" -f Green
 
    #Cleanup List Templates in source and destination sites
    Remove-PnPFile -ServerRelativeUrl $SourceListTemplateURL -Recycle -Force -Connection $SourceConn
    Remove-PnPFile -ServerRelativeUrl $DestinationListTemplateURL -Recycle -Force -Connection $DestinationConn
    }
    Catch {
        write-host -f Red "Error:" $_.Exception.Message
    }
}
 
#Parameters
	$SourceSiteURL = "https://inet.postfallsidaho.org/cityhallit/"
	$DestinationSiteURL = "https://postfallsidahoorg.sharepoint.com/sites/Generaltesting"
	 
	$SourceLibraryName = "Procedures Library"
	$DestinationLibraryName = "Procedures Library"

<#
$SourceSiteURL = "https://crescent.sharepoint.com/sites/Legal"
$DestinationSiteURL = "https://crescent.sharepoint.com/sites/Compliance"
$SourceLibraryName = "Documents"
$DestinationLibraryName = "Documents"
 #>

#Call the function to copy document library to another site
Copy-PnPLibrary -SourceSiteURL $SourceSiteURL -DestinationSiteURL $DestinationSiteURL -SourceLibraryName $SourceLibraryName -DestinationLibraryName $DestinationLibraryName
