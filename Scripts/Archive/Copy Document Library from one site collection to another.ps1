<# Copy Document Library from one site collection to another in SharePoint Online 
https://docs.microsoft.com/en-us/answers/questions/225952/copy-document-library-from-one-site-collection-to.html
 #>
 
 Function Copy-AllFilesWithMetadata
 {
   param
     (
         [Parameter(Mandatory=$true)] [Microsoft.SharePoint.Client.Folder] $SourceFolder,
         [Parameter(Mandatory=$true)] [Microsoft.SharePoint.Client.Folder] $TargetFolder
     )
     Try {
         #Get all Files from the source folder
         $SourceFilesColl = $SourceFolder.Files
         $SourceFolder.Context.Load($SourceFilesColl)
         $SourceFolder.Context.ExecuteQuery()
     
         #Iterate through each file and copy
         Foreach($SourceFile in $SourceFilesColl)
         {
             #Get the source file
             $FileInfo = [Microsoft.SharePoint.Client.File]::OpenBinaryDirect($SourceFolder.Context, $SourceFile.ServerRelativeUrl)
                 
             #Copy File to the Target location
             $TargetFileURL = $TargetFolder.ServerRelativeUrl+"/"+$SourceFile.Name
             [Microsoft.SharePoint.Client.File]::SaveBinaryDirect($TargetFolder.Context, $TargetFileURL, $FileInfo.Stream,$True)
     
             #Copy Metadata field values
             $SourceListItem = $SourceFile.ListItemAllFields
             $SourceFolder.Context.Load($SourceListItem)
             $SourceFolder.Context.ExecuteQuery()
                 
             #Get the new file created
             $TargetFile = $TargetFolder.Context.Web.GetFileByServerRelativeUrl($TargetFileURL)
             $TargetListItem = $TargetFile.ListItemAllFields
                 
             #Set Metadata values from the source
             $Author =$TargetFolder.Context.web.EnsureUser($SourceListItem["Author"].Email)
             $TargetListItem["Author"] = $Author
             $Editor =$TargetFolder.Context.web.EnsureUser($SourceListItem["Editor"].Email)
             $TargetListItem["Editor"] = $Editor
             $TargetListItem["Created"] = $SourceListItem["Created"]
             $TargetListItem["Modified"] = $SourceListItem["Modified"]
             $TargetListItem.Update()
             $TargetFolder.Context.ExecuteQuery()
     
             Write-host -f Green "Copied File '$($SourceFile.ServerRelativeUrl)' to '$TargetFileURL'"
         }
     
         #Process Sub Folders
         $SubFolders = $SourceFolder.Folders
         $SourceFolder.Context.Load($SubFolders)
         $SourceFolder.Context.ExecuteQuery()
         Foreach($SubFolder in $SubFolders)
         {
             If($SubFolder.Name -ne "Forms")
             {
                 #Prepare Target Folder
                 $TargetFolderURL = $SubFolder.ServerRelativeUrl -replace $SourceLibrary.RootFolder.ServerRelativeUrl, $TargetLibrary.RootFolder.ServerRelativeUrl
                 Try {
                         $Folder=$TargetFolder.Context.web.GetFolderByServerRelativeUrl($TargetFolderURL)
                         $TargetFolder.Context.load($Folder)
                         $TargetFolder.Context.ExecuteQuery()
                     }
                 catch {
                         #Create Folder
                         if(!$Folder.Exists)
                         {
                             $TargetFolderURL
                             $Folder=$TargetFolder.Context.web.Folders.Add($TargetFolderURL)
                             $TargetFolder.Context.Load($Folder)
                             $TargetFolder.Context.ExecuteQuery()
                             Write-host "Folder Added:"$SubFolder.Name -f Yellow
                         }
                     }
                 #Call the function recursively
                 Copy-AllFilesWithMetadata -SourceFolder $SubFolder -TargetFolder $Folder
             }
         }
     }
     Catch {
         write-host -f Red "Error Copying File!" $_.Exception.Message
     }
 }
     
#Load SharePoint CSOM Assemblies
	Add-Type -Path "\\sharepoint-svr\c$\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
	Add-Type -Path "\\sharepoint-svr\c$\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

#Add required references to OfficeDevPnP.Core and SharePoint client assembly
	[System.Reflection.Assembly]::LoadFrom("C:\Program Files\WindowsPowerShell\Modules\SharePointPnPPowerShell2019\3.29.2101.0\OfficeDevPnP.Core.dll") 
	[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
	[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")


#Set Parameter values
	$SourceSiteURL = "https://inet.postfallsidaho.org/cityhallit/"
	$TargetSiteURL = "https://postfallsidahoorg.sharepoint.com/sites/Generaltesting"
	 
	$SourceLibraryName = "Procedures Library"
	$TargetLibraryName = "Procedures Library"

	$ID = "4073db67-6f22-41ea-996c-1ef89531db53"
	$Secret = "cWBbiDYl1+cZU8Xw7l3GkgN2qUotxRrF6Jd6WBZAbR8="
 
	<# #Setup Credentials to connect
		$Cred= Get-Credential -credential amalin@postfalls.gov
		$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.Username, $Cred.Password)
	#> 

#SOURCE set the context
	$AuthenticationManager = new-object OfficeDevPnP.Core.AuthenticationManager
	$SourceCtx = $AuthenticationManager.GetWebLoginClientContext($SourceSiteURL)
    $SourceCtx.Load($SourceCtx.Web)
    $SourceCtx.ExecuteQuery()


#SOURCE GET library 
	$SourceLibrary = $SourceCtx.Web.Lists.GetByTitle($SourceLibraryName)
	$SourceCtx.Load($SourceLibrary)
	$SourceCtx.Load($SourceLibrary.RootFolder)
 
 
#TARGET set the context
	$AuthenticationManager = new-object OfficeDevPnP.Core.AuthenticationManager
	$TargetCtx = $AuthenticationManager.GetWebLoginClientContext($TargetSiteURL)
    $TargetCtx.Load($TargetCtx.Web)
    $TargetCtx.ExecuteQuery()

#TARGET Get Library
	$TargetLibrary = $TargetCtx.Web.Lists.GetByTitle($TargetLibraryName)
	$TargetCtx.Load($TargetLibrary)
	$TargetCtx.Load($TargetLibrary.RootFolder)

 
#Call the function
	Copy-AllFilesWithMetadata -SourceFolder $SourceLibrary.RootFolder -TargetFolder $TargetLibrary.RootFolder

