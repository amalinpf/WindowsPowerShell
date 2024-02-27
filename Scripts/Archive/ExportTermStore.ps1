<#
10/29/20 ajm, to export Managed Terms
	From https://cann0nf0dder.wordpress.com/2014/11/12/exporting-taxonomy-from-sharepoint-using-powershell/
	
Breaking the PowerShell file down
Parameters

There are 7 different parameters and 6 of them are Manatory.
AdminUser

The user who has adminitrative access to the term store. (e.g., On-Prem: Domain\user or for 365: user@sp.com)
AdminPassword

The password for the Admin User.
AdminUrl

The URL of Central Admin for On-Prem or Admin site for 365
PathToExportXMLTerms

The path you wish to save the XML Output to. This path must exist.
XMLTermsFileName

The name of the XML file to save. If the file already exists then it will be overwritten.
PathToSPClientdlls

The script requires to call the following dlls:
Microsoft.SharePoint.Client.dll
Microsoft.SharePoint.Client.Runtime.dll
Microsoft.SharePoint.Client.Taxonomy.dll

(e.g., C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI) Or you can download SharePoint Client SDK which will have the dll’s
GroupToExport

An optional parameter, if included only the Group will be exported. If omitted then the entire termstore will be written to XML.
Load and Connect to SharePoint Function

This function will return an SPContext, it will use CSOM to connect to the SharePoint Admin site. There is a line of code that checks if the URL contains “.sharepoint.com”, we can assume that if it does then it is an online SharePoint tenant and will require to connect using a different sign in method. The function requires the SharePoint admin URL, User, Password and path to the client dlls.
#>

function LoadAndConnectToSharePoint($url, $user, $password, $dllPath){
 
 #Convert password to secure string
 
 $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
 #Get SPClient Dlls Path
 $spClientdllsDir = Get-Item $dllPath
 #Add required Client Dlls
 Add-Type -Path "$($spClientdllsDir.FullName)\Microsoft.SharePoint.Client.dll"
 Add-Type -Path "$($spClientdllsDir.FullName)\Microsoft.SharePoint.Client.Runtime.dll"
 Add-Type -Path "$($spClientdllsDir.FullName)\Microsoft.SharePoint.Client.Taxonomy.dll"
 $spContext = New-Object Microsoft.SharePoint.Client.ClientContext($url)
 if($url.Contains(".sharepoint.com")) # SharePoint Online
 {    
    $credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User, $securePassword)
 }
 else # SharePoint On-premises
 {    
    $networkCredentials = new-object -TypeName System.Net.NetworkCredential
    $networkCredentials.UserName = $user.Split('\')[1]
    $networkCredentials.Password = $password
    $networkCredentials.Domain = $user.Split('\')[0]
    [System.Net.CredentialCache]$credentials = new-object -TypeName System.Net.CredentialCache
    $uri = [System.Uri]$url
    $credentials.Add($uri, "NTLM", $networkCredentials)
}
 #See if we can establish a connection
 $spContext.Credentials = $credentials
 $spContext.RequestTimeOut = 5000 * 60 * 10;
 $web = $spContext.Web
 $site = $spContext.Site
 $spContext.Load($web)
 $spContext.Load($site)
 try
 {
    $spContext.ExecuteQuery()
    Write-Host "Established connection to SharePoint at $Url OK" -foregroundcolor Green
}
catch
{
    Write-Host "Not able to connect to SharePoint at $Url. Exception:$_.Exception.Message" -foregroundcolor red
    exit 1
}
 return $spContext
}

<#$Get TermStore Info

This function using the SPContext will return the TermStore. If you have multiple termstores (which you might have in your on prem environment) you might need to modify the code not to just bring back the termstore at index 0.
#>

function Get-TermStoreInfo($spContext){
 $spTaxSession = [Microsoft.SharePoint.Client.Taxonomy.TaxonomySession]::GetTaxonomySession($spContext)
 $spTaxSession.UpdateCache();
 $spContext.Load($spTaxSession)
 
 try
 {
 $spContext.ExecuteQuery()
 }
 catch
 {
  Write-host "Error while loading the Taxonomy Session " $_.Exception.Message -ForegroundColor Red
  exit 1
 }
 
 if($spTaxSession.TermStores.Count -eq 0){
  write-host "The Taxonomy Service is offline or missing" -ForegroundColor Red
  exit 1
 }
 
 $termStores = $spTaxSession.TermStores
 $spContext.Load($termStores)
 
 try
 {
  $spContext.ExecuteQuery()
  $termStore = $termStores[0]
  $spcontext.Load($termStore)
  $spContext.ExecuteQuery()
  Write-Host "Connected to TermStore: $($termStore.Name) ID: $($termStore.Id)"
 }
 catch
 {
  Write-host "Error details while getting term store ID" $_.Exception.Message -ForegroundColor Red
  exit 1
 }
 return $termStore
}
<# Get XML TermStore Template To File

This creates an empty XML template, very similar to Gary Lapointe XML file. I’m passing in the Term Store Name and the path to where I want to save the .XML file. The code creates a template.xml file which is a temporary file. This blank template is used later on. It should contain all the relevant bits of information about the term store. Through XPath, which you will see later, we can recursively node sections (e.g, Custom Properties, Terms, TermSets, Groups etc.)
 #>

 function Get-XMLTermStoreTemplateToFile($termStoreName, $path){
 ## Set up an xml template used for creating your exported xml
 $xmlTemplate = '<TermStores>
 <TermStore Name="' + $termStoreName + '" IsOnline="True" WorkingLanguage="1033" DefaultLanguage="1033" SystemGroup="c6fb3e37-0997-42b1-8e3c-2706a36adbc4">
 <Groups>
 <Group Id="" Name="" Description="" IsSystemGroup="False" IsSiteCollectionGroup="False">
 <TermSets>
 <TermSet Id="" Name="" Description="" Contact="" IsAvailableForTagging="" IsOpenForTermCreation="" CustomSortOrder="False">
 <CustomProperties>
 <CustomProperty Key="" Value=""/>
 </CustomProperties>
 <Terms>
 <Term Id="" Name="" IsDeprecated="" IsAvailableForTagging="" IsKeyword="" IsReused="" IsRoot="" IsSourceTerm="" CustomSortOrder="False">
 <Descriptions>
 <Description Language="1033" Value="" />
 </Descriptions>
 <CustomProperties>
 <CustomProperty Key="" Value="" />
 </CustomProperties>
 <LocalCustomProperties>
 <LocalCustomProperty Key="" Value="" />
 </LocalCustomProperties>
 <Labels>
 <Label Value="" Language="1033" IsDefaultForLanguage="" />
 </Labels>
 <Terms>
 <Term Id="" Name="" IsDeprecated="" IsAvailableForTagging="" IsKeyword="" IsReused="" IsRoot="" IsSourceTerm="" CustomSortOrder="False">
 <Descriptions>
 <Description Language="1033" Value="" />
 </Descriptions>
 <CustomProperties>
 <CustomProperty Key="" Value="" />
 </CustomProperties>
 <LocalCustomProperties>
 <LocalCustomProperty Key="" Value="" />
 </LocalCustomProperties>
 <Labels>
 <Label Value="" Language="1033" IsDefaultForLanguage="" />
 </Labels>
 </Term>
 </Terms>
 </Term>
 </Terms>
 </TermSet>
 </TermSets>
 </Group>
 </Groups>
 </TermStore>
 </TermStores>'
 
try
{
 #Save Template to disk
 $xmlTemplate | Out-File($path + "\Template.xml")
 
 #Load file and return
 $xml = New-Object XML
 $xml.Load($path + "\Template.xml")
 return $xml
 }
 catch{
 Write-host "Error creating Template file. " $_.Exception.Message -ForegroundColor Red
 exit 1
 }
}
<# Get XML File Object Templates

Using Global variables, the template XML file is being broken down into sections, so at the given time when I’m exporting the TermSet I can grab a node, fill it in, and then add it to the final XML file. Using XPath I’m grabbing, Group, TermSet, Term, Term Label, Term Description, Term Custom Properties and Tern Local Custom properties.
 #>

function Get-XMLFileObjectTemplates($xml){
 #Grab template elements so that we can easily copy them later.
   $global:xmlGroupT = $xml.selectSingleNode('//Group[@Id=""]') 
    $global:xmlTermSetT = $xml.selectSingleNode('//TermSet[@Id=""]') 
    $global:xmlTermT = $xml.selectSingleNode('//Term[@Id=""]')
 $global:xmlTermLabelT = $xml.selectSingleNode('//Label[@Value=""]')
 $global:xmlTermDescriptionT = $xml.selectSingleNode('//Description[@Value=""]')
 $global:xmlTermCustomPropertiesT = $xml.selectSingleNode('//CustomProperty[@Key=""]')
 $global:xmlTermLocalCustomPropertiesT = $xml.selectSingleNode('//LocalCustomProperty[@Key=""]')
}
<# Get Groups

This function will be called from the actual Export Taxonomy Function. A call would have already been made to obtain all Groups within the TermStore and passed into this function. It will loop through each Group, ignoring system groups, and if the parameter $GroupToExport was supplied it will skip all groups until it finds the given group. Once found it will grab a clone of GroupXMLTemplate and fill out the required information, then add the clone to the template XML in the correct place. It will then try to load any TermSets for the group.
 #>

 function Get-Groups($spContext, $groups, $xml, $groupToExport){
 #Loop through all groups, ignoring system Groups
 $groups | Where-Object { $_.IsSystemGroup -eq $false} | ForEach-Object{
 
 #Check if we are getting groups or just group.
 if($groupToExport -ne "")
 {
 if($groupToExport -ne $_.name){
 #Return acts like a continue in ForEach-Object
 return;
 }
 }
 
 #Add each group to export xml by cloning the template group,
 #populating it and appending it
 $xmlNewGroup = $global:xmlGroupT.Clone()
 $xmlNewGroup.Name = $_.name
 $xmlNewGroup.id = $_.id.ToString()
 $xmlNewGroup.Description = $_.description
 $xml.TermStores.TermStore.Groups.AppendChild($xmlNewGroup) | Out-Null
 
 write-Host "Adding Group " -NoNewline
 write-Host $_.name -ForegroundColor Green
 
 $spContext.Load($_.TermSets)
 try
 {
 $spContext.ExecuteQuery()
 }
 catch
 {
 Write-host "Error while loaded TermSets for Group " $xmlNewGroup.Name " " $_.Exception.Message -ForegroundColor Red
 exit 1
 }
 
 Get-TermSets $spContext $xmlNewGroup $_.Termsets $xml
 }
}
<# Get Term Sets

This function is called from Get-Groups Function. A call was made in Get-Groups to obtain all TermSets within the Group and passed into this function. It will loop through each TermSet, grab a clone of TermSetXMLTemplate and fill out the required information, skipping CustomSortOrder and Custom properties if they do not exist, or grabbing a clone of their template and filling in the information. Then add the clone to the template XML in the correct place. It will then try to load any Terms for the termset.

You will notice on the 6th line down I am replacing an ampersand with another. This is because the one that SharePoint is a different character to ampersand you get when you press & on your keyboard. This just tidies the data in the XML and prevents problems with string matching in importing.
 #>

function Get-TermSets($spContext, $xmlnewGroup, $termSets, $xml){
 $termSets | ForEach-Object{
 #Add each termset to the export xml
 $xmlNewSet = $global:xmlTermSetT.Clone()
 #Replace SharePoint ampersand with regular
 $xmlNewSet.Name = $_.Name.replace("＆", "&")
 
 $xmlNewSet.Id = $_.Id.ToString()
 
 if ($_.CustomSortOrder -ne $null)
 {
 $xmlNewSet.CustomSortOrder = $_.CustomSortOrder.ToString()
 }
 
 foreach($customprop in $_.CustomProperties.GetEnumerator())
 {
 ## Clone Term customProp node
 $xmlNewTermCustomProp = $global:xmlTermCustomPropertiesT.Clone()    
 
 $xmlNewTermCustomProp.Key = $($customProp.Key)
 $xmlNewTermCustomProp.Value = $($customProp.Value)
 $xmlNewSet.CustomProperties.AppendChild($xmlNewTermCustomProp) | Out-Null
 }
 
 $xmlNewSet.Description = $_.Description.ToString()
 $xmlNewSet.Contact = $_.Contact.ToString()
    $xmlNewSet.IsOpenForTermCreation = $_.IsOpenForTermCreation.ToString()  
    $xmlNewSet.IsAvailableForTagging = $_.IsAvailableForTagging.ToString()  
    $xmlNewGroup.TermSets.AppendChild($xmlNewSet) | Out-Null
 
 Write-Host "Adding TermSet " -NoNewline
 Write-Host $_.name -ForegroundColor Green -NoNewline
 Write-Host " to Group " -NoNewline
 Write-Host $xmlNewGroup.Name -ForegroundColor Green
 
 $spContext.Load($_.Terms)
 try
 {
 $spContext.ExecuteQuery()
 }
 catch
 {
 Write-host "Error while loading Terms for TermSet " $_.name " " $_.Exception.Message -ForegroundColor Red
 exit 1
 }
 # Recursively loop through all the terms in this termset
    Get-Terms $spContext $_.Terms $xml
 }
 }
<# Get Terms

This function is called from Get-TermSets Function. A call was made in Get-TermSets (Or Get-Terms if collection is a sub terms) to obtain all Terms within the TermSet and passed into this function. It will loop through each Terms, grab a clone of TermXMLTemplate and fill out the required information. A Term has lots of repeating data for it, such as Custom Properties, Local Properties etc, which uses given XMLTemplates to store information then append to the XML term. Lastly Labels, TermSets information, Parent information and subTerms require an additional context load. The parent and TermSet information is used to ensure if sub terms, they are added to the correct location within the XML Template. The loading of the Terms (sub terms) for this current term is then passed back into Get-TermSet function, recursively calling itself until no sub terms can be found. *Hopefully the code is more explanatory to you then my description here.
#Terms could be either the original termset or parent term with children terms
 #> 

function Get-Terms($spContext, $_.Terms, $xml) {
 $terms | ForEach-Object{
 #Create a new term xml Element
 $xmlNewTerm = $global:xmlTermT.Clone()
 #Replace SharePoint ampersand with regular
 $xmlNewTerm.Name = $_.Name.replace("＆", "&")
 $xmlNewTerm.id = $_.Id.ToString()
 $xmlNewTerm.IsAvailableForTagging = $_.IsAvailableForTagging.ToString()
 $xmlNewTerm.IsKeyword = $_.IsKeyword.ToString()
 $xmlNewTerm.IsReused = $_.IsReused.ToString()
 $xmlNewTerm.IsRoot = $_.IsRoot.ToString()
    $xmlNewTerm.IsSourceTerm = $_.IsSourceterm.ToString()
    $xmlNewTerm.IsDeprecated = $_.IsDeprecated.ToString()
 
 if($_.CustomSortOrder -ne $null)
 {
 $xmlNewTerm.CustomSortOrder = $_.CustomSortOrder.ToString()
 }
 
 #Custom Properties
 foreach($customprop in $_.CustomProperties.GetEnumerator())
 {
 # Clone Term customProp node
 $xmlNewTermCustomProp = $global:xmlTermCustomPropertiesT.Clone()    
 
 $xmlNewTermCustomProp.Key = $($customProp.Key)
 $xmlNewTermCustomProp.Value = $($customProp.Value)
 $xmlNewTerm.CustomProperties.AppendChild($xmlNewTermCustomProp)  | Out-Null
 }
 
 #Local Properties
 foreach($localProp in $_.LocalCustomProperties.GetEnumerator())
 {
 # Clone Term LocalProp node
 $xmlNewTermLocalCustomProp = $global:xmlTermLocalCustomPropertiesT.Clone()    
 
 $xmlNewTermLocalCustomProp.Key = $($localProp.Key)
 $xmlNewTermLocalCustomProp.Value = $($localProp.Value)
 $xmlNewTerm.LocalCustomProperties.AppendChild($xmlNewTermLocalCustomProp) | Out-Null
 }
 
 if($_.Description -ne "")
 {
 $xmlNewTermDescription = $global:xmlTermDescriptionT.Clone()    
 $xmlNewTermDescription.Value = $_.Description
 $xmlNewTerm.Descriptions.AppendChild($xmlNewTermDescription) | Out-Null
 }
 
 $spContext.Load($_.Labels)
 $spContext.Load($_.TermSet)
 $spContext.Load($_.Parent)
 $spContext.Load($_.Terms)
 
 try
 {
 $spContext.ExecuteQuery()
 }
 catch
 {
 Write-host "Error while loaded addition information for Term " $xmlNewTerm.Name " " $_.Exception.Message -ForegroundColor Red
 exit 1
 }
 
 foreach($label in $_.Labels)
 {
 ## Clone Term Label node
 $xmlNewTermLabel = $global:xmlTermLabelT.Clone()
 $xmlNewTermLabel.Value = $label.Value.ToString()
 $xmlNewTermLabel.Language = $label.Language.ToString()
 $xmlNewTermLabel.IsDefaultForLanguage = $label.IsDefaultForLanguage.ToString()
        $xmlNewTerm.Labels.AppendChild($xmlNewTermLabel) | Out-Null
 }
 
 # Use this terms parent term or parent termset in the termstore to find it's matching parent
     # in the export xml
     if ($_.parent.Id -ne $null) {
      # Both guids are needed as a term can appear in multiple termsets
        $parentGuid = $_.parent.Id.ToString()
        $parentTermsetGuid = $_.Termset.Id.ToString()
 #$_.Parent.Termset.Id.ToString()
     }
 else
 {
      $parentGuid = $_.Termset.Id.ToString()
     }     
 
 # Get this terms parent in the xml      
     $parent = Get-TermByGuid $xml $parentGuid $parentTermsetGuid     
 
 $parentGuid = $null;
 
 #Append new Term to Parent
 $parent.Terms.AppendChild($xmlNewTerm) | Out-Null
 
 Write-Host "Adding Term " -NoNewline
 Write-Host $_.name -ForegroundColor Green -NoNewline
 Write-Host " to Parent " -NoNewline
 Write-Host $parent.Name -ForegroundColor Green
 
 #If this term has child terms we need to loop through those
 if($_.Terms.Count -gt 0){
 #Recursively call itself
 Get-Terms $spContext $_.Terms $xml
 }
 }
}
<# Get Terms By Guid

This function is used with Get-Terms. All it is doing is returning the corresponding selected nodes from the XML template, passing in either the TermGuid, or Parent TermSet Guid.
 #>

function Get-TermByGuid($xml, $guid, $parentTermsetGuid) {
      if ($parentTermsetGuid) {
        return  $xml.selectnodes('//Term[@Id="' + $guid + '"]')
    } else {
        return  $xml.selectnodes('//TermSet[@Id="' + $guid + '"]')
    }
}
<# Clean Template

The Clean template function is called just before saving the completed XML to disk. This ensures any empty elements are removed from the XML.
 #>

function Clean-Template($xml) {
    #Do not cleanup empty description nodes (this is the default state)
 
 ## Empty Term.Labels.Label
    $xml.selectnodes('//Label[@Value=""]') | ForEach-Object {
        $parent = $_.get_ParentNode()
        $parent.RemoveChild($_)  | Out-Null      
    } 
 ## Empty Term
 $xml.selectnodes('//Term[@Id=""]') | ForEach-Object {
        $parent = $_.get_ParentNode()
        $parent.RemoveChild($_)  | Out-Null      
    } 
 ## Empty TermSet
    $xml.selectnodes('//TermSet[@Id=""]') | ForEach-Object {
        $parent = $_.get_ParentNode()
        $parent.RemoveChild($_)  | Out-Null      
    } 
 ## Empty Group
    $xml.selectnodes('//Group[@Id=""]') | ForEach-Object {
        $parent = $_.get_ParentNode()
        $parent.RemoveChild($_)   | Out-Null     
    }
 ## Empty Custom Properties
 $xml.selectnodes('//CustomProperty[@Key=""]') | ForEach-Object {
 $parent = $_.get_ParentNode()
 $parent.RemoveChild($_) | Out-Null
 }
 
 ## Empty Local Custom proeprties
 $xml.selectnodes('//LocalCustomProperty[@Key=""]') | ForEach-Object {
 $parent = $_.get_ParentNode()
 $parent.RemoveChild($_) | Out-Null
 }
 
 $xml.selectnodes('//Descriptions')| ForEach-Object {
 $childNodes = $_.ChildNodes.Count
 if($childNodes -gt 1)
 {
 $_.RemoveChild($_.ChildNodes[0]) | Out-Null
 }
 }
 
 While ($xml.selectnodes('//Term[@Id=""]').Count -gt 0)
 {
 #Cleanup the XML, remove empty Term Nodes
 $xml.selectnodes('//Term[@Id=""]').RemoveAll() | Out-Null
 }
 }

<# Export Taxonomy
This function ties all the other functions together really. It starts at calling the groups, then once that has pushed down and iterated through all the other methods, the XML is tidied, then saved to the filename given in the parameters. All temporary file are deleted.
 #>

function ExportTaxonomy($spContext, $termStore, $xml, $groupToExport, $path, $saveFileName){
 $spContext.Load($termStore.Groups)
 try
 {
 $spContext.ExecuteQuery();
 }
 catch
 {
 Write-host "Error while loaded Groups from TermStore " $_.Exception.Message -ForegroundColor Red
 exit 1
 }
 
 Get-Groups $spContext $termStore.Groups $xml $groupToExport
 
 #Clean up empty tags/nodes
 Clean-Template $xml
 
 #Save file.
 try
 {
 $xml.Save($path + "\NewTaxonomy.xml")
 
 #Clean up empty <Term> unable to work out in Clean-Template.
 Get-Content ($path + "\NewTaxonomy.xml") | Foreach-Object { $_ -replace "<Term><\/Term>", "" } | Set-Content ($path + "\" + $saveFileName)
 Write-Host "Saving XML file " $saveFileName " to " $path
 
 #Remove temp file
 Remove-Item($path + "\Template.xml");
 Remove-Item($path + "\NewTaxonomy.xml");
 }
 catch
 {
 Write-host "Error saving XML File to disk " $_.Exception.Message -ForegroundColor Red
 exit 1
 }
}
<# 
How to Export TermSet with the PowerShell command.
Both these examples use a SharePoint online account/site, but you can easily point it to an on premise site. To view all details the powershell file has a help file which can be called ./Export-Taxonomy.ps1 -help
This exports the entire termstore.
./Export-Taxonomy.ps1 -AdminUser user@sp.com -AdminPassword password -AdminUrl https://sp-admin.onmicrosoft.com -PathToExportXMLTerms c:\myTerms -XMLTermsFileName exportterms.xml -PathToSPClientdlls &quot;C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI&quot;
This exports just the Term Store Group ‘Client Group Terms’

 .\ExportTermStore.ps1 -AdminUser amalin@postfallsidaho.org -AdminPassword Cathyyyy.. -AdminUrl http://sharepoint-dev/ -PathToExportXMLTerms c:\myTerms -XMLTermsFileName exportterms.xml -PathToSPClientdlls 'C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI' 
 
 -GroupToExport 'Site Collection - sharepoint-dev'
 #>


