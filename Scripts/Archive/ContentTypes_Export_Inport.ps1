#Function to EXPORT the Content Type in SharePoint Online using powershell	https://www.sharepointdiary.com/2018/02/sharepoint-online-export-import-content-type-using-powershell.html

################################################################################################
################################################################################################
#################################### EXPORT ####################################################
################################################################################################
################################################################################################


Function Export-PnPContentType
{
    param
    (
        [string]$SiteURL  = $(throw "Enter the Site URL!"),
        [string]$ContentTypeName = $(throw "Enter the Content Type Name!"),
        [string]$ExportFile = $(throw "Enter the File to Export!")
    )
    Try {
        #Connect to SharePoint Online
        Connect-PnPOnline -Url $SiteURL -Interactive
		Connect-PnPOnline -Url https://inet.postfallsidaho.org -CurrentCredentials
 
        #Get the content type to Export
        $ContentType = Get-PnPContentType -Identity $ContentTypeName -ErrorAction SilentlyContinue
  
        If($ContentType -ne $Null)
        {
            #Create Export XML File and export the schema of the content type
            New-Item $ExportFile -type file -force | Out-Null
  
            #sharepoint online powershell export content type
            Add-Content $ExportFile "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
            Add-Content $ExportFile $ContentType.SchemaXml
   
            write-host "Content Type '$ContentTypeName' Exported Successfully!" -ForegroundColor  Green
        }
        else
        {            
            Write-Host "Content Type '$ContentTypeName' doesn't Exist in the Site!" -ForegroundColor Yellow
        }
    }
    Catch {
        write-host -f Red "Error Exporting Content Type!" $_.Exception.Message
    }
}
  
#Variables
$SiteURL = "	https://inet.postfallsidaho.org/clerk"
$ContentTypeName= "Certificates Of Insurance"
$ExportFile = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\Templates\CertOfIns.xml"
# $ContentTypeName= "Clerk Budget Documents"
# $ExportFile = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\Templates\ClerkBudget.xml"
 
#Call the function to Export the content type
Export-PnPContentType -SiteURL $SiteURL -ContentTypeName $ContentTypeName -ExportFile $ExportFile

################################################################################################
################################################################################################
#################################### IMPORT ####################################################
################################################################################################
################################################################################################

#Function to IMPORT the Content Type in SharePoint Online using powershell	https://www.sharepointdiary.com/2018/02/sharepoint-online-export-import-content-type-using-powershell.html

Function Import-PnPContentType
{
    param
    (
        [string]$SiteURL  = $(throw "Enter the Site URL!"),
        [string]$ContentTypeName = $(throw "Enter the Content Type Name!"),
        [string]$ImportFile = $(throw "Enter the File to Import!")
    )
    Try {
        #Connect to SharePoint Online
        Connect-PnPOnline -Url $SiteURL -Interactive
 
        #Check if the content type to exists already
        $ContentType = Get-PnPContentType -Identity $ContentTypeName -ErrorAction SilentlyContinue
         
        If($ContentType -eq $Null)
        {
            #Import the XML File
            $ContentTypeXML = [xml](Get-Content($ImportFile))
 
            #Create the content type
            $ContentType = Add-PnPContentType -Name $ContentTypeName -Description $ContentTypeXML.ContentType.Description -Group $ContentTypeXML.ContentType.Group            
            Write-host "Content Type '$ContentTypeName' Created Successfully!" -ForegroundColor Green
 
            Write-host "Adding Fields to the Content Type..." -ForegroundColor Yellow
            #Remove the "Version" Attribute from the XML
            $ContentTypeXML.ContentType.Fields.Field.RemoveAttribute("Version")
             
            #Add Fields to content type
            ForEach($Field in $ContentTypeXML.ContentType.Fields.Field)
            {
                #Get existing fields from content type
                $ContentTypeFields = Get-PnPProperty -ClientObject $ContentType -Property Fields
                 
                #Check if the content type has the field already!
                $ContentTypeField = $ContentTypeFields | Where {$_.InternalName -eq $Field.Name}
                If($ContentTypeField -eq $Null)
                {
                    #Get the site column
                    $SiteColumn = Get-PnPField | Where {$_.InternalName -eq $Field.Name}
                    If($SiteColumn -eq $Null)
                    {
                        #Add Site column to Web
                        Add-PnPFieldFromXml -FieldXml $Field.OuterXml 
                        Write-host "Site Column Added:" $($Field.Name)
                    }
                    Else
                    {
                        Write-host -f Yellow "`tSite Column '$($Field.Name)' Already Exists.. Skipping Creating site column"
                    } 
 
                    #get the field to add to content type
                    $SiteColumn = Get-PnPField | Where {$_.InternalName -eq $Field.Name}
                    #Add Field to Content type
                    Add-PnPFieldToContentType -Field $SiteColumn -ContentType $ContentTypeName
 
                    Write-host "`tField '$($Field.Name)' Added to Content Type" -Foregroundcolor Green
                }
            } 
            write-host "Content Type '$ContentTypeName' Imported Successfully!" -ForegroundColor  Green
        }
        else
        {            
            Write-Host "Content Type '$ContentTypeName' Already Exist in the Site!" -ForegroundColor Yellow
        }
    }
    Catch {
        write-host -f Red "Error Importing Content Type!" $_.Exception.Message
    } 
}
 
#Variables
$SiteURL = "https://postfallsidahoorg.sharepoint.com/sites/contentTypeHub"
$ContentTypeName= "Certificates Of Insurance"
$ExportFile = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\Templates\CertOfIns.xml"
# $ContentTypeName= "Clerk Budget Documents"
# $ExportFile = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\sharepoint\Templates\ClerkBudget.xml"
 
#Call the function to Import the content type
Import-PnPContentType -SiteURL $SiteURL -ContentTypeName $ContentTypeName -ImportFile $ImportFile

