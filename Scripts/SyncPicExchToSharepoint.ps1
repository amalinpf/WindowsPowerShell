#https://answers.microsoft.com/en-us/msoffice/forum/all/why-wont-sharepoint-show-everyones-profile-photos/daa37899-783a-4897-a56f-63ba635cf875

#Add references to SharePoint client assemblies and authenticate to Office 365 site as required for CSOM
Add-Type -AssemblyName System.Drawing

Function UploadImage ()
{
	Param(
	  [Parameter(Mandatory=$True)]
	  [String]$SiteURL,

	  [Parameter(Mandatory=$True)]
	  [String]$SPOAdminPortalUrl,

	  [Parameter(Mandatory=$True, HelpMessage="Enter user email address or All for all mailboxes")]
	  [String]$UserEmail

	)

	#Default Image library and Folder value 
	$DocLibName ="User Photos"
	$foldername="Profile Pictures"

    Connect-ExchangeOnline
    $siteConnection = Connect-PnPOnline -Url $SiteURL –Interactive -ReturnConnection

    #NOTE: there is a bug in Set-PnPUserProfileProperty in which the ConnectPnPOnline must connect with the UseWebLogin option 
    # https://github.com/pnp/powershell/issues/277
    $adminConnection = Connect-PnPOnline -Url $SPOAdminPortalUrl –UseWebLogin -ReturnConnection

	$spoimagename = @{"_SThumb" = "48"; "_MThumb" = "72"; "_LThumb" = "200"}

write-host "getting images, user is $UserEmail"

    $allUserMailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox

    Foreach($mailbox in $allUserMailboxes)
    {

        if(($mailbox.PrimarySmtpAddress -eq $UserEmail) -or ($UserEmail -eq "All")){
            Write-Host "Processing " $mailbox.PrimarySmtpAddress

            try{
		        #Download Image from Exchange online 
                $photo = Get-UserPhoto -Identity $mailbox.Identity
		        Write-Host "Exchange online image downloaded successful for" $mailbox.PrimarySmtpAddress

		        $username = $mailbox.PrimarySmtpAddress.Replace("@", "_").Replace(".", "_")

		        $Extension = ".jpg"
		        Foreach($imagename in $spoimagename.GetEnumerator())
		        {
			        #Covert image into different size of image
                    $ms = new-object System.IO.MemoryStream(,$photo.PictureData)
			        $img = [System.Drawing.Image]::FromStream($ms)
			        [int32]$new_width = $imagename.Value
			        [int32]$new_height = $imagename.Value
			        $img2 = New-Object System.Drawing.Bitmap($new_width, $new_height)
			        $graph = [System.Drawing.Graphics]::FromImage($img2)
			        $graph.DrawImage($img, 0, 0, $new_width, $new_height)

			        #Covert image into memory stream
			        $stream = New-Object -TypeName System.IO.MemoryStream
			        $format = [System.Drawing.Imaging.ImageFormat]::Jpeg
			        $img2.Save($stream, $format)
			        $streamseek=$stream.Seek(0, [System.IO.SeekOrigin]::Begin)

			        #Upload image into sharepoint online
			        $FullFilename=$username+$imagename.Name+$Extension
                    Add-PnPFile -Connection $siteConnection -Folder "User Photos/Profile Pictures" -FileName $FullFilename -Stream $stream                                

		        }
		        Write-Host "SharePoint online image uploaded successful for" $mailbox.PrimarySmtpAddress
		        #Change user Profile Property in Sharepoint onlne 
		        $PictureURL=$SiteURL+$DocLibName+"/"+$foldername+"/"+$username+"_MThumb"+$Extension

                Set-PnPUserProfileProperty -Connection $adminConnection -Account $mailbox.PrimarySmtpAddress -PropertyName PictureURL -Value $PictureURL

                Set-PnPUserProfileProperty -Connection $adminConnection -Account $mailbox.PrimarySmtpAddress -PropertyName SPS-PicturePlaceholderState -Value 0

                Set-PnPUserProfileProperty -Connection $adminConnection -Account $mailbox.PrimarySmtpAddress -PropertyName SPS-PictureExchangeSyncState -Value 0

                Set-PnPUserProfileProperty -Connection $adminConnection -Account $mailbox.PrimarySmtpAddress -PropertyName SPS-PictureTimestamp -Value 63605901091

		        Write-Host "Image processed successfully and ready to display for" $mailbox.PrimarySmtpAddress
            }catch{
                $ErrorMessage = $_.Exception.Message
                Write-Host "Failed to process " $mailbox.PrimarySmtpAddress -ForegroundColor red
                Write-Host $ErrorMessage -ForegroundColor red
            }
	    }        
    }

}

#Input parameter
$siteUrl="https://postfallsidahoorg.sharepoint.com/"
$SPOAdminPortalUrl = "https://postfallsidahoorg-admin.sharepoint.com/"
$UserEmail = "amalin@postfalls.gov"

uploadimage -SiteURL $siteUrl -SPOAdminPortalUrl $SPOAdminPortalUrl -UserEmail $UserEmail

<# 
$UserEmail = "michaelK@postfalls.gov"
$UserEmail = "amalinusr@postfalls.gov"
$UserEmail = "amalinmgr@postfalls.gov"



$Extension = "jpg"
$username = "amalin"
$DocLibName ="User Photos"
	$foldername="Profile Pictures"
$PictureURL=$SiteURL+$DocLibName+"/"+$foldername+"/"+$username+"_MThumb"+$Extension
$PictureURL


https://postfallsidahoorg.sharepoint.com/User%20Photos/Profile%20Pictures
https://postfallsidahoorg.sharepoint.com/User%20Photos/Profile%20Pictures/amalin_postfalls_gov_LThumb.jpg
https://postfallsidahoorg.sharepoint.com/User%20Photos/Profile%20Pictures/mheck_postfalls_gov_LThumb.jpg
https://postfallsidahoorg.sharepoint.com/User%20Photos/Profile%20Pictures/janetb_postfalls_gov_LThumb.jpg
https://postfallsidahoorg.sharepoint.com/User%20Photos/Profile%20Pictures/amealer_postfalls_gov_LThumb.jpg


https://postfallsidahoorg-my.sharepoint.com:443/User%20Photos/Profile%20Pictures/amalin_postfalls_gov_MThumb.jpg


 if(($mailbox.PrimarySmtpAddress -eq "amalinmgr@postfalls.gov") -or ($mailbox.PrimarySmtpAddress -eq "mkirby@postfalls.gov") -or ($mailbox.PrimarySmtpAddress -eq "michaelK@postfalls.gov") -or ($mailbox.PrimarySmtpAddress -eq "amalinusr@postfalls.gov") -or ($mailbox.PrimarySmtpAddress -eq "jcollins@postfalls.gov")){
	 
	 
	 
$UserEmail = "jcollins@postfalls.gov"
$UserEmail = "mkirby@postfalls.gov"
$UserEmail = "michaelK@postfalls.gov"
$UserEmail = "amalinusr@postfalls.gov"
$UserEmail = "amalinmgr@postfalls.gov"




https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=mheck@postfalls.gov
https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=janetb@postfalls.gov
https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=amealer@postfalls.gov
https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=amalin@postfalls.gov
https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=jcollins@postfalls.gov
https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=michaelk@postfalls.gov
https://postfallsidahoorg-admin.sharepoint.com/_layouts/15/userphoto.aspx?size=L&username=mkirby@postfalls.gov



 #>