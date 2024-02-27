@{
	NestedModules =  'Core/PnP.PowerShell.dll'
	ModuleVersion = '2.2.0'
	Description = 'Microsoft 365 Patterns and Practices PowerShell Cmdlets'
	GUID = '0b0430ce-d799-4f3b-a565-f0dca1f31e17'
	Author = 'Microsoft 365 Patterns and Practices'
	CompanyName = 'Microsoft 365 Patterns and Practices'	
	ProcessorArchitecture = 'None'
	FunctionsToExport = '*'  
	CmdletsToExport = @("Add-PnPAdaptiveScopeProperty","Add-PnPPropertyBagValue","Add-PnPSiteClassification","Copy-PnPFolder","Get-PnPClientSidePage","Get-PnPMicrosoft365GroupMembers","Get-PnPMicrosoft365GroupOwners","Get-PnPSiteClassification","Invoke-PnPSearchQuery","Move-PnPClientSideComponent","Remove-PnPClientSidePage","Remove-PnPSiteClassitication","Set-PnPClientSidePage","Update-PnPVivaConnectionsDashboardACE","Update-SiteClassification","Add-PnPAlert","Add-PnPApp","Add-PnPApplicationCustomizer","Add-PnPAvailableSiteClassification","Add-PnPAzureADGroupMember","Add-PnPAzureADGroupOwner","Add-PnPAzureADServicePrincipalAppRole","Add-PnPContentType","Add-PnPContentTypesFromContentTypeHub","Add-PnPContentTypeToDocumentSet","Add-PnPContentTypeToList","Add-PnPCustomAction","Add-PnPDataRowsToSiteTemplate","Add-PnPDocumentSet","Add-PnPEventReceiver","Add-PnPField","Add-PnPFieldFromXml","Add-PnPFieldToContentType","Add-PnPFile","Add-PnPFileAnonymousSharingLink","Add-PnPFileOrganizationalSharingLink","Add-PnPFileSharingInvite","Add-PnPFileToSiteTemplate","Add-PnPFileUserSharingLink","Add-PnPFolder","Add-PnPFolderAnonymousSharingLink","Add-PnPFolderOrganizationalSharingLink","Add-PnPFolderSharingInvite","Add-PnPFolderUserSharingLink","Add-PnPGroupMember","Add-PnPHtmlPublishingPageLayout","Add-PnPHubSiteAssociation","Add-PnPHubToHubAssociation","Add-PnPIndexedProperty","Add-PnPJavaScriptBlock","Add-PnPJavaScriptLink","Add-PnPListDesign","Add-PnPListFoldersToSiteTemplate","Add-PnPListItem","Add-PnPListItemAttachment","Add-PnPListItemComment","Add-PnPMasterPage","Add-PnPMicrosoft365GroupMember","Add-PnPMicrosoft365GroupOwner","Add-PnPMicrosoft365GroupToSite","Add-PnPNavigationNode","Add-PnPOrgAssetsLibrary","Add-PnPOrgNewsSite","Add-PnPPage","Add-PnPPageImageWebPart","Add-PnPPageSection","Add-PnPPageTextPart","Add-PnPPageWebPart","Add-PnPPlannerBucket","Add-PnPPlannerRoster","Add-PnPPlannerRosterMember","Add-PnPPlannerTask","Add-PnPPublishingImageRendition","Add-PnPPublishingPage","Add-PnPPublishingPageLayout","Add-PnPRoleDefinition","Add-PnPSiteCollectionAdmin","Add-PnPSiteCollectionAppCatalog","Add-PnPSiteDesign","Add-PnPSiteDesignFromWeb","Add-PnPSiteDesignTask","Add-PnPSiteScript","Add-PnPSiteScriptPackage","Add-PnPSiteTemplate","Add-PnPStoredCredential","Add-PnPTaxonomyField","Add-PnPTeamsChannel","Add-PnPTeamsChannelUser","Add-PnPTeamsTab","Add-PnPTeamsTeam","Add-PnPTeamsUser","Add-PnPTenantCdnOrigin","Add-PnPTenantSequence","Add-PnPTenantSequenceSite","Add-PnPTenantSequenceSubSite","Add-PnPTenantTheme","Add-PnPTermToTerm","Add-PnPView","Add-PnPViewsFromXML","Add-PnPVivaConnectionsDashboardACE","Add-PnPWebhookSubscription","Add-PnPWebPartToWebPartPage","Add-PnPWebPartToWikiPage","Add-PnPWikiPage","Approve-PnPTenantServicePrincipalPermissionRequest","Clear-PnPAzureADGroupMember","Clear-PnPAzureADGroupOwner","Clear-PnPDefaultColumnValues","Clear-PnPListItemAsRecord","Clear-PnPMicrosoft365GroupMember","Clear-PnPMicrosoft365GroupOwner","Clear-PnPRecycleBinItem","Clear-PnPTenantAppCatalogUrl","Clear-PnPTenantRecycleBinItem","Connect-PnPOnline","Convert-PnPFolderToSiteTemplate","Convert-PnPSiteTemplate","Convert-PnPSiteTemplateToMarkdown","ConvertTo-PnPPage","Copy-PnPFile","Copy-PnPItemProxy","Copy-PnPList","Copy-PnPTeamsTeam","Deny-PnPTenantServicePrincipalPermissionRequest","Disable-PnPFeature","Disable-PnPFlow","Disable-PnPPageScheduling","Disable-PnPPowerShellTelemetry","Disable-PnPSharingForNonOwnersOfSite","Disable-PnPSiteClassification","Disable-PnPTenantServicePrincipal","Disconnect-PnPOnline","Enable-PnPCommSite","Enable-PnPFeature","Enable-PnPFlow","Enable-PnPPageScheduling","Enable-PnPPowerShellTelemetry","Enable-PnPSiteClassification","Enable-PnPTenantServicePrincipal","Export-PnPFlow","Export-PnPListToSiteTemplate","Export-PnPPage","Export-PnPPageMapping","Export-PnPTaxonomy","Export-PnPTermGroupToXml","Export-PnPUserInfo","Export-PnPUserProfile","Find-PnPFile","Get-PnPAccessToken","Get-PnPAlert","Get-PnPApp","Get-PnPAppAuthAccessToken","Get-PnPAppErrors","Get-PnPAppInfo","Get-PnPApplicationCustomizer","Get-PnPAuditing","Get-PnPAuthenticationRealm","Get-PnPAvailableLanguage","Get-PnPAvailablePageComponents","Get-PnPAvailableSensitivityLabel","Get-PnPAvailableSiteClassification","Get-PnPAzureACSPrincipal","Get-PnPAzureADActivityReportDirectoryAudit","Get-PnPAzureADActivityReportSignIn","Get-PnPAzureADApp","Get-PnPAzureADAppPermission","Get-PnPAzureADAppSitePermission","Get-PnPAzureADGroup","Get-PnPAzureADGroupMember","Get-PnPAzureADGroupOwner","Get-PnPAzureADServicePrincipal","Get-PnPAzureADServicePrincipalAssignedAppRole","Get-PnPAzureADServicePrincipalAvailableAppRole","Get-PnPAzureADUser","Get-PnPAzureCertificate","Get-PnPBrowserIdleSignout","Get-PnPBuiltInDesignPackageVisibility","Get-PnPBuiltInSiteTemplateSettings","Get-PnPChangeLog","Get-PnPCompatibleHubContentTypes","Get-PnPConnection","Get-PnPContentType","Get-PnPContentTypePublishingHubUrl","Get-PnPContentTypePublishingStatus","Get-PnPContext","Get-PnPCustomAction","Get-PnPDefaultColumnValues","Get-PnPDeletedMicrosoft365Group","Get-PnPDeletedTeam","Get-PnPDiagnostics","Get-PnPDisableSpacesActivation","Get-PnPDocumentSetTemplate","Get-PnPEventReceiver","Get-PnPException","Get-PnPExternalUser","Get-PnPFeature","Get-PnPField","Get-PnPFile","Get-PnPFileSharingLink","Get-PnPFileVersion","Get-PnPFlow","Get-PnPFlowRun","Get-PnPFolder","Get-PnPFolderItem","Get-PnPFolderSharingLink","Get-PnPFolderStorageMetric","Get-PnPFooter","Get-PnPGraphAccessToken","Get-PnPGraphSubscription","Get-PnPGroup","Get-PnPGroupMember","Get-PnPGroupPermissions","Get-PnPHideDefaultThemes","Get-PnPHomePage","Get-PnPHomeSite","Get-PnPHubSite","Get-PnPHubSiteChild","Get-PnPIndexedPropertyKeys","Get-PnPInPlaceRecordsManagement","Get-PnPIsSiteAliasAvailable","Get-PnPJavaScriptLink","Get-PnPKnowledgeHubSite","Get-PnPLabel","Get-PnPLargeListOperationStatus","Get-PnPList","Get-PnPListDesign","Get-PnPListInformationRightsManagement","Get-PnPListItem","Get-PnPListItemAttachment","Get-PnPListItemComment","Get-PnPListItemPermission","Get-PnPListItemVersion","Get-PnPListPermissions","Get-PnPListRecordDeclaration","Get-PnPMasterPage","Get-PnPMessageCenterAnnouncement","Get-PnPMicrosoft365ExpiringGroup","Get-PnPMicrosoft365Group","Get-PnPMicrosoft365GroupEndpoint","Get-PnPMicrosoft365GroupMember","Get-PnPMicrosoft365GroupOwner","Get-PnPMicrosoft365GroupSettings","Get-PnPMicrosoft365GroupSettingTemplates","Get-PnPMicrosoft365GroupTeam","Get-PnPMicrosoft365GroupYammerCommunity","Get-PnPNavigationNode","Get-PnPOrgAssetsLibrary","Get-PnPOrgNewsSite","Get-PnPPage","Get-PnPPageComponent","Get-PnPPlannerBucket","Get-PnPPlannerConfiguration","Get-PnPPlannerPlan","Get-PnPPlannerRosterMember","Get-PnPPlannerRosterPlan","Get-PnPPlannerTask","Get-PnPPlannerUserPolicy","Get-PnPPowerApp","Get-PnPPowerPlatformEnvironment","Get-PnPPowerShellTelemetryEnabled","Get-PnPProperty","Get-PnPPropertyBag","Get-PnPPublishingImageRendition","Get-PnPRecycleBinItem","Get-PnPRequestAccessEmails","Get-PnPRoleDefinition","Get-PnPSearchConfiguration","Get-PnPSearchCrawlLog","Get-PnPSearchSettings","Get-PnPServiceCurrentHealth","Get-PnPServiceHealthIssue","Get-PnPSharePointAddIn","Get-PnPSharingForNonOwnersOfSite","Get-PnPSite","Get-PnPSiteClosure","Get-PnPSiteCollectionAdmin","Get-PnPSiteCollectionAppCatalog","Get-PnPSiteCollectionTermStore","Get-PnPSiteDesign","Get-PnPSiteDesignRights","Get-PnPSiteDesignRun","Get-PnPSiteDesignRunStatus","Get-PnPSiteDesignTask","Get-PnPSiteGroup","Get-PnPSitePolicy","Get-PnPSiteScript","Get-PnPSiteScriptFromList","Get-PnPSiteScriptFromWeb","Get-PnPSiteSearchQueryResults","Get-PnPSiteSensitivityLabel","Get-PnPSiteTemplate","Get-PnPSiteUserInvitations","Get-PnPStorageEntity","Get-PnPStoredCredential","Get-PnPStructuralNavigationCacheSiteState","Get-PnPStructuralNavigationCacheWebState","Get-PnPSubWeb","Get-PnPSyntexModel","Get-PnPSyntexModelPublication","Get-PnPTaxonomyItem","Get-PnPTaxonomySession","Get-PnPTeamsApp","Get-PnPTeamsChannel","Get-PnPTeamsChannelFilesFolder","Get-PnPTeamsChannelMessage","Get-PnPTeamsChannelMessageReply","Get-PnPTeamsChannelUser","Get-PnPTeamsPrimaryChannel","Get-PnPTeamsTab","Get-PnPTeamsTag","Get-PnPTeamsTeam","Get-PnPTeamsUser","Get-PnPTemporarilyDisableAppBar","Get-PnPTenant","Get-PnPTenantAppCatalogUrl","Get-PnPTenantCdnEnabled","Get-PnPTenantCdnOrigin","Get-PnPTenantCdnPolicies","Get-PnPTenantDeletedSite","Get-PnPTenantId","Get-PnPTenantInstance","Get-PnPTenantRecycleBinItem","Get-PnPTenantSequence","Get-PnPTenantSequenceSite","Get-PnPTenantServicePrincipal","Get-PnPTenantServicePrincipalPermissionGrants","Get-PnPTenantServicePrincipalPermissionRequests","Get-PnPTenantSite","Get-PnPTenantSyncClientRestriction","Get-PnPTenantTemplate","Get-PnPTenantTheme","Get-PnPTerm","Get-PnPTermGroup","Get-PnPTermLabel","Get-PnPTermSet","Get-PnPTheme","Get-PnPTimeZoneId","Get-PnPUnfurlLink","Get-PnPUnifiedAuditLog","Get-PnPUPABulkImportStatus","Get-PnPUser","Get-PnPUserOneDriveQuota","Get-PnPUserProfileProperty","Get-PnPView","Get-PnPVivaConnectionsDashboardACE","Get-PnPWeb","Get-PnPWebHeader","Get-PnPWebhookSubscriptions","Get-PnPWebPart","Get-PnPWebPartProperty","Get-PnPWebPartXml","Get-PnPWebTemplates","Get-PnPWikiPageContent","Grant-PnPAzureADAppSitePermission","Grant-PnPHubSiteRights","Grant-PnPSiteDesignRights","Grant-PnPTenantServicePrincipalPermission","Import-PnPTaxonomy","Import-PnPTermGroupFromXml","Import-PnPTermSet","Install-PnPApp","Invoke-PnPBatch","Invoke-PnPGraphMethod","Invoke-PnPListDesign","Invoke-PnPQuery","Invoke-PnPSiteDesign","Invoke-PnPSiteScript","Invoke-PnPSiteSwap","Invoke-PnPSiteTemplate","Invoke-PnPSPRestMethod","Invoke-PnPTenantTemplate","Invoke-PnPTransformation","Invoke-PnPWebAction","Measure-PnPList","Measure-PnPWeb","Move-PnPFile","Move-PnPFolder","Move-PnPItemProxy","Move-PnPListItemToRecycleBin","Move-PnPPageComponent","Move-PnPRecycleBinItem","Move-PnPTerm","Move-PnPTermSet","New-PnPAzureADGroup","New-PnPAzureADUserTemporaryAccessPass","New-PnPAzureCertificate","New-PnPBatch","New-PnPExtensibilityHandlerObject","New-PnPGraphSubscription","New-PnPGroup","New-PnPList","New-PnPMicrosoft365Group","New-PnPMicrosoft365GroupSettings","New-PnPPersonalSite","New-PnPPlannerPlan","New-PnPSdnProvider","New-PnPSite","New-PnPSiteCollectionTermStore","New-PnPSiteGroup","New-PnPSiteTemplate","New-PnPSiteTemplateFromFolder","New-PnPTeamsApp","New-PnPTeamsTeam","New-PnPTenantSequence","New-PnPTenantSequenceCommunicationSite","New-PnPTenantSequenceTeamNoGroupSite","New-PnPTenantSequenceTeamNoGroupSubSite","New-PnPTenantSequenceTeamSite","New-PnPTenantSite","New-PnPTenantTemplate","New-PnPTerm","New-PnPTermGroup","New-PnPTermLabel","New-PnPTermSet","New-PnPUPABulkImportJob","New-PnPUser","New-PnPWeb","Publish-PnPApp","Publish-PnPCompanyApp","Publish-PnPContentType","Publish-PnPSyntexModel","Read-PnPSiteTemplate","Read-PnPTenantTemplate","Receive-PnPCopyMoveJobStatus","Register-PnPAppCatalogSite","Register-PnPAzureADApp","Register-PnPHubSite","Register-PnPManagementShellAccess","Remove-PnPAdaptiveScopeProperty","Remove-PnPAlert","Remove-PnPApp","Remove-PnPApplicationCustomizer","Remove-PnPAvailableSiteClassification","Remove-PnPAzureADApp","Remove-PnPAzureADGroup","Remove-PnPAzureADGroupMember","Remove-PnPAzureADGroupOwner","Remove-PnPAzureADServicePrincipalAssignedAppRole","Remove-PnPContentType","Remove-PnPContentTypeFromDocumentSet","Remove-PnPContentTypeFromList","Remove-PnPCustomAction","Remove-PnPDeletedMicrosoft365Group","Remove-PnPEventReceiver","Remove-PnPExternalUser","Remove-PnPField","Remove-PnPFieldFromContentType","Remove-PnPFile","Remove-PnPFileFromSiteTemplate","Remove-PnPFileSharingLink","Remove-PnPFileVersion","Remove-PnPFlow","Remove-PnPFolder","Remove-PnPFolderSharingLink","Remove-PnPGraphSubscription","Remove-PnPGroup","Remove-PnPGroupMember","Remove-PnPHomeSite","Remove-PnPHubSiteAssociation","Remove-PnPHubToHubAssociation","Remove-PnPIndexedProperty","Remove-PnPJavaScriptLink","Remove-PnPKnowledgeHubSite","Remove-PnPList","Remove-PnPListDesign","Remove-PnPListItem","Remove-PnPListItemAttachment","Remove-PnPListItemComment","Remove-PnPListItemVersion","Remove-PnPMicrosoft365Group","Remove-PnPMicrosoft365GroupMember","Remove-PnPMicrosoft365GroupOwner","Remove-PnPMicrosoft365GroupSettings","Remove-PnPNavigationNode","Remove-PnPOrgAssetsLibrary","Remove-PnPOrgNewsSite","Remove-PnPPage","Remove-PnPPageComponent","Remove-PnPPlannerBucket","Remove-PnPPlannerPlan","Remove-PnPPlannerRoster","Remove-PnPPlannerRosterMember","Remove-PnPPlannerTask","Remove-PnPPropertyBagValue","Remove-PnPPublishingImageRendition","Remove-PnPRoleDefinition","Remove-PnPSdnProvider","Remove-PnPSearchConfiguration","Remove-PnPSiteCollectionAdmin","Remove-PnPSiteCollectionAppCatalog","Remove-PnPSiteCollectionTermStore","Remove-PnPSiteDesign","Remove-PnPSiteDesignTask","Remove-PnPSiteGroup","Remove-PnPSiteScript","Remove-PnPSiteSensitivityLabel","Remove-PnPSiteUserInvitations","Remove-PnPStorageEntity","Remove-PnPStoredCredential","Remove-PnPTaxonomyItem","Remove-PnPTeamsApp","Remove-PnPTeamsChannel","Remove-PnPTeamsChannelUser","Remove-PnPTeamsTab","Remove-PnPTeamsTag","Remove-PnPTeamsTeam","Remove-PnPTeamsUser","Remove-PnPTenantCdnOrigin","Remove-PnPTenantDeletedSite","Remove-PnPTenantSite","Remove-PnPTenantSyncClientRestriction","Remove-PnPTenantTheme","Remove-PnPTerm","Remove-PnPTermGroup","Remove-PnPTermLabel","Remove-PnPUser","Remove-PnPUserInfo","Remove-PnPUserProfile","Remove-PnPView","Remove-PnPVivaConnectionsDashboardACE","Remove-PnPWeb","Remove-PnPWebhookSubscription","Remove-PnPWebPart","Remove-PnPWikiPage","Rename-PnPFile","Rename-PnPFolder","Rename-PnPTenantSite","Repair-PnPSite","Request-PnPAccessToken","Request-PnPPersonalSite","Request-PnPReIndexList","Request-PnPReIndexWeb","Request-PnPSyntexClassifyAndExtract","Reset-PnPFileVersion","Reset-PnPLabel","Reset-PnPMicrosoft365GroupExpiration","Reset-PnPUserOneDriveQuotaToDefault","Resolve-PnPFolder","Restart-PnPFlowRun","Restore-PnPDeletedMicrosoft365Group","Restore-PnPFileVersion","Restore-PnPListItemVersion","Restore-PnPRecycleBinItem","Restore-PnPTenantRecycleBinItem","Restore-PnPTenantSite","Revoke-PnPAzureADAppSitePermission","Revoke-PnPHubSiteRights","Revoke-PnPSiteDesignRights","Revoke-PnPTenantServicePrincipalPermission","Revoke-PnPUserSession","Save-PnPPageConversionLog","Save-PnPSiteTemplate","Save-PnPTenantTemplate","Send-PnPMail","Set-PnPAdaptiveScopeProperty","Set-PnPApplicationCustomizer","Set-PnPAppSideLoading","Set-PnPAuditing","Set-PnPAvailablePageLayouts","Set-PnPAzureADAppSitePermission","Set-PnPAzureADGroup","Set-PnPBrowserIdleSignout","Set-PnPBuiltInDesignPackageVisibility","Set-PnPBuiltInSiteTemplateSettings","Set-PnPContentType","Set-PnPContext","Set-PnPDefaultColumnValues","Set-PnPDefaultContentTypeToList","Set-PnPDefaultPageLayout","Set-PnPDisableSpacesActivation","Set-PnPDocumentSetField","Set-PnPField","Set-PnPFileCheckedIn","Set-PnPFileCheckedOut","Set-PnPFolderPermission","Set-PnPFooter","Set-PnPGraphSubscription","Set-PnPGroup","Set-PnPGroupPermissions","Set-PnPHideDefaultThemes","Set-PnPHomePage","Set-PnPHomeSite","Set-PnPHubSite","Set-PnPImageListItemColumn","Set-PnPIndexedProperties","Set-PnPInPlaceRecordsManagement","Set-PnPKnowledgeHubSite","Set-PnPLabel","Set-PnPList","Set-PnPListInformationRightsManagement","Set-PnPListItem","Set-PnPListItemAsRecord","Set-PnPListItemPermission","Set-PnPListPermission","Set-PnPListRecordDeclaration","Set-PnPMasterPage","Set-PnPMessageCenterAnnouncementAsArchived","Set-PnPMessageCenterAnnouncementAsFavorite","Set-PnPMessageCenterAnnouncementAsNotArchived","Set-PnPMessageCenterAnnouncementAsNotFavorite","Set-PnPMessageCenterAnnouncementAsRead","Set-PnPMessageCenterAnnouncementAsUnread","Set-PnPMicrosoft365Group","Set-PnPMicrosoft365GroupSettings","Set-PnPMinimalDownloadStrategy","Set-PnPPage","Set-PnPPageTextPart","Set-PnPPageWebPart","Set-PnPPlannerBucket","Set-PnPPlannerConfiguration","Set-PnPPlannerPlan","Set-PnPPlannerTask","Set-PnPPlannerUserPolicy","Set-PnPPropertyBagValue","Set-PnPRequestAccessEmails","Set-PnPRoleDefinition","Set-PnPSearchConfiguration","Set-PnPSearchSettings","Set-PnPSite","Set-PnPSiteClassification","Set-PnPSiteClosure","Set-PnPSiteDesign","Set-PnPSiteGroup","Set-PnPSitePolicy","Set-PnPSiteScript","Set-PnPSiteScriptPackage","Set-PnPSiteSensitivityLabel","Set-PnPSiteTemplateMetadata","Set-PnPStorageEntity","Set-PnPStructuralNavigationCacheSiteState","Set-PnPStructuralNavigationCacheWebState","Set-PnPTaxonomyFieldValue","Set-PnPTeamifyPromptHidden","Set-PnPTeamsChannel","Set-PnPTeamsChannelUser","Set-PnPTeamsTab","Set-PnPTeamsTag","Set-PnPTeamsTeam","Set-PnPTeamsTeamArchivedState","Set-PnPTeamsTeamPicture","Set-PnPTemporarilyDisableAppBar","Set-PnPTenant","Set-PnPTenantAppCatalogUrl","Set-PnPTenantCdnEnabled","Set-PnPTenantCdnPolicy","Set-PnPTenantSite","Set-PnPTenantSyncClientRestriction","Set-PnPTerm","Set-PnPTermGroup","Set-PnPTermSet","Set-PnPTheme","Set-PnPTraceLog","Set-PnPUserOneDriveQuota","Set-PnPUserProfileProperty","Set-PnPView","Set-PnPVivaConnectionsDashboardACE","Set-PnPWeb","Set-PnPWebHeader","Set-PnPWebhookSubscription","Set-PnPWebPartProperty","Set-PnPWebPermission","Set-PnPWebTheme","Set-PnPWikiPageContent","Stop-PnPFlowRun","Submit-PnPSearchQuery","Submit-PnPTeamsChannelMessage","Sync-PnPAppToTeams","Sync-PnPSharePointUserProfilesFromAzureActiveDirectory","Test-PnPListItemIsRecord","Test-PnPMicrosoft365GroupAliasIsUsed","Test-PnPSite","Test-PnPTenantTemplate","Undo-PnPFileCheckedOut","Uninstall-PnPApp","Unpublish-PnPApp","Unpublish-PnPContentType","Unpublish-PnPSyntexModel","Unregister-PnPHubSite","Update-PnPApp","Update-PnPAvailableSiteClassification","Update-PnPSiteDesignFromWeb","Update-PnPTeamsApp","Update-PnPTeamsUser","Update-PnPUserType")
	VariablesToExport = '*'
	AliasesToExport = '*'
	FormatsToProcess = 'PnP.PowerShell.Format.ps1xml' 
	PrivateData = @{
		PSData = @{
			Tags = 'SharePoint','PnP','Teams','Planner'
			ProjectUri = 'https://aka.ms/sppnp'
			IconUri = 'https://raw.githubusercontent.com/pnp/media/40e7cd8952a9347ea44e5572bb0e49622a102a12/parker/ms/300w/parker-ms-300.png'
		}
	}
}

# SIG # Begin signature block
# MIInlgYJKoZIhvcNAQcCoIInhzCCJ4MCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCAlARWOow56lMk
# Iqm85l19e21tJ1O9CB1cydWjquRj2aCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
# esGEb+srAAAAAANOMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMwMzE2MTg0MzI5WhcNMjQwMzE0MTg0MzI5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDdCKiNI6IBFWuvJUmf6WdOJqZmIwYs5G7AJD5UbcL6tsC+EBPDbr36pFGo1bsU
# p53nRyFYnncoMg8FK0d8jLlw0lgexDDr7gicf2zOBFWqfv/nSLwzJFNP5W03DF/1
# 1oZ12rSFqGlm+O46cRjTDFBpMRCZZGddZlRBjivby0eI1VgTD1TvAdfBYQe82fhm
# WQkYR/lWmAK+vW/1+bO7jHaxXTNCxLIBW07F8PBjUcwFxxyfbe2mHB4h1L4U0Ofa
# +HX/aREQ7SqYZz59sXM2ySOfvYyIjnqSO80NGBaz5DvzIG88J0+BNhOu2jl6Dfcq
# jYQs1H/PMSQIK6E7lXDXSpXzAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUnMc7Zn/ukKBsBiWkwdNfsN5pdwAw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMDUxNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAD21v9pHoLdBSNlFAjmk
# mx4XxOZAPsVxxXbDyQv1+kGDe9XpgBnT1lXnx7JDpFMKBwAyIwdInmvhK9pGBa31
# TyeL3p7R2s0L8SABPPRJHAEk4NHpBXxHjm4TKjezAbSqqbgsy10Y7KApy+9UrKa2
# kGmsuASsk95PVm5vem7OmTs42vm0BJUU+JPQLg8Y/sdj3TtSfLYYZAaJwTAIgi7d
# hzn5hatLo7Dhz+4T+MrFd+6LUa2U3zr97QwzDthx+RP9/RZnur4inzSQsG5DCVIM
# pA1l2NWEA3KAca0tI2l6hQNYsaKL1kefdfHCrPxEry8onJjyGGv9YKoLv6AOO7Oh
# JEmbQlz/xksYG2N/JSOJ+QqYpGTEuYFYVWain7He6jgb41JbpOGKDdE/b+V2q/gX
# UgFe2gdwTpCDsvh8SMRoq1/BNXcr7iTAU38Vgr83iVtPYmFhZOVM0ULp/kKTVoir
# IpP2KCxT4OekOctt8grYnhJ16QMjmMv5o53hjNFXOxigkQWYzUO+6w50g0FAeFa8
# 5ugCCB6lXEk21FFB1FdIHpjSQf+LP/W2OV/HfhC3uTPgKbRtXo83TZYEudooyZ/A
# Vu08sibZ3MkGOJORLERNwKm2G7oqdOv4Qj8Z0JrGgMzj46NFKAxkLSpE5oHQYP1H
# tPx1lPfD7iNSbJsP6LiUHXH1MIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGXYwghlyAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEINa17sHFR0OYEeDtC4cuyd+j
# p51MPfqibc5LapEH6rpuMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAxJKThIuSboQkpC36uKEaQ8Pb7EsUWdnxXWDrY1FwtIoUttLzV5PFB+W+
# h7ozood0AU3BxEFm3B/OZmkSTKhglbCToCg87ZrsTBTkXnt3ktP6QakKkUlnTXLg
# kMtx2z6puPD1Ptv1nyUCcW0xqUWksswvOf//HllemAg7YhS7DiQ258PyWUU0AU/m
# TYwVsnDC3379UcCNccbuCpU0MdBxXfLIILchzjQZd+leRTNSk6yrlAjgqSnviUPG
# lbVUPKD0Eph117FFGDvwrFSK6e5DS4LqfWt/dEhHnwJqVhPU/kjq2WGV6uPBhHvU
# GhDslaAFJjp+deDtHocBOVMVsNOmI6GCFwAwghb8BgorBgEEAYI3AwMBMYIW7DCC
# FugGCSqGSIb3DQEHAqCCFtkwghbVAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFRBgsq
# hkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCC2XxBPmfybVuRZdUhR9o280nh3xj8Z8k0etfu7g4utiAIGZIsdsDEl
# GBMyMDIzMDYzMDEzMjgxMi42NTVaMASAAgH0oIHQpIHNMIHKMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo3QkYxLUUz
# RUEtQjgwODElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCC
# EVcwggcMMIIE9KADAgECAhMzAAAByPmw7mft6mtGAAEAAAHIMA0GCSqGSIb3DQEB
# CwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIyMTEwNDE5MDEz
# N1oXDTI0MDIwMjE5MDEzN1owgcoxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMx
# JjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOjdCRjEtRTNFQS1CODA4MSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEAucudfihPgyRWwnnIuJCqc3TCtFk0XOimFcKjU9bS6WFn
# g2l+FrIid0mPZ7KWs6Ewj21X+ZkGkM6x+ozHlmNtnHSQ48pjIFdlKXIoh7fSo41A
# 4n0tQIlwhs8uIYIocp72xwDBHKSZxGaEa/0707iyOw+aXZXNcTxgNiREASb9thlL
# ZM75mfJIgBVvUmdLZc+XOUYwz/8ul7IEztPNH4cn8Cn0tJhIFfp2netr8GYNoiyI
# qxueG7+sSt2xXl7/igc5cHPZnWhfl9PaB4+SutrA8zAhzVHTnj4RffxA4R3k4BRb
# PdGowQfOf95ZeYxLTHf5awB0nqZxOY+yuGWhf6hp5RGRouc9beVZv98M1erYa55S
# 1ahZgGDQJycVtEy82RlmKfTYY2uNmlPLWtnD7sDlpVkhYQGKuTWnuwQKq9ZTSE+0
# V2cH8JaWBYJQMIuWWM83vLPo3IT/S/5jT2oZOS9nsJgwwCwRUtYtwtq8/PJtvt1V
# 6VoG4Wd2/MAifgEJOkHF7ARPqI9Xv28+riqJZ5mjLGz84dP2ryoe0lxYSz3PT5Er
# KoS0+zJpYNAcxbv2UXiTk3Wj/mZ3tulz6z4XnSl5gy0PLer+EVjz4G96GcZgK2d9
# G+uYylHWwBneIv9YFQj6yMdW/4sEpkEbrpiJNemcxUCmBipZ7Sc35rv4utkJ4/UC
# AwEAAaOCATYwggEyMB0GA1UdDgQWBBS1XC9JgbrSwLDTiJJT4iK7NUvk9TAfBgNV
# HSMEGDAWgBSfpxVdAF5iXYP05dJlpxtTNRnpcjBfBgNVHR8EWDBWMFSgUqBQhk5o
# dHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBU
# aW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcmwwbAYIKwYBBQUHAQEEYDBeMFwG
# CCsGAQUFBzAChlBodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRz
# L01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNydDAMBgNV
# HRMBAf8EAjAAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMA0GCSqGSIb3DQEBCwUAA4IC
# AQDD1nJSyEPDqSgnfkFifIbteJb7NkZCbRj5yBGiT1f9fTGvUb5CW7k3eSp3uxUq
# om9LWykcNfQa/Yfw0libEim9YRjUNcL42oIFqtp/7rl9gg61oiB8PB+6vLEmjXkY
# xUUR8WjKKC5Q5dx96B21faSco2MOmvjYxGUR7An+4529lQPPLqbEKRjcNQb+p+mk
# QH2XeMbsh5EQCkTuYAimFTgnui2ZPFLEuBpxBK5z2HnKneHUJ9i4pcKWdCqF1AOV
# N8gXIH0R0FflMcCg5TW8v90Vwx/mP3aE2Ige1uE8M9YNBn5776PxmA16Z+c2s+hY
# I+9sJZhhRA8aSYacrlLz7aU/56OvEYRERQZttuAFkrV+M/J+tCeGNv0Gd75Y4lKL
# Mp5/0xoOviPBdB2rD5C/U+B8qt1bBqQLVZ1wHRy0/6HhJxbOi2IgGJaOCYLGX2zz
# 0VAT6mZ2BTWrJmcK6SDv7rX7psgC+Cf1t0R1aWCkCHJtpYuyKjf7UodRazevOf6V
# 01XkrARHKrI7bQoHFL+sun2liJCBjN51mDWoEgUCEvwB3l+RFYAL0aIisc5cTaGX
# /T8F+iAbz+j2GGVum85gEQS9uLzSedoYPyEXxTblwewGdAxqIZaKozRBow49OnL+
# 5CgooVMf3ZSqpxc2QC0E03l6c/vChkYyqMXq7Lwd4PnHqjCCB3EwggVZoAMCAQIC
# EzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBS
# b290IENlcnRpZmljYXRlIEF1dGhvcml0eSAyMDEwMB4XDTIxMDkzMDE4MjIyNVoX
# DTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDk4aZM57RyIQt5osvXJHm9DtWC
# 0/3unAcH0qlsTnXIyjVX9gF/bErg4r25PhdgM/9cT8dm95VTcVrifkpa/rg2Z4VG
# Iwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPFdvWGUNzBRMhxXFExN6AKOG6N7dcP
# 2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6GnszrYBbfowQHJ1S/rboYiXcag/P
# XfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBpDco2LXCOMcg1KL3jtIckw+DJj361
# VI/c+gVVmG1oO5pGve2krnopN6zL64NF50ZuyjLVwIYwXE8s4mKyzbnijYjklqwB
# Sru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3EXzTdEonW/aUgfX782Z5F37ZyL9t9
# X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0lBw0gg/wEPK3Rxjtp+iZfD9M269e
# wvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1qGFphAXPKZ6Je1yh2AuIzGHLXpyDw
# wvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ+QuJYfM2BjUYhEfb3BvR/bLUHMVr
# 9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PAPBXbGjfHCBUYP3irRbb1Hode2o+e
# FnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkwEgYJKwYBBAGCNxUBBAUCAwEAATAj
# BgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxGNSnPEP8vBO4wHQYDVR0OBBYEFJ+n
# FV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARVMFMwUQYMKwYBBAGCN0yDfQEBMEEw
# PwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9j
# cy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAKBggrBgEFBQcDCDAZBgkrBgEEAYI3
# FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAf
# BgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBH
# hkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNS
# b29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUF
# BzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0Nl
# ckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAnVV9/Cqt4Swf
# ZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0xM7U518JxNj/aZGx80HU5bbsPMeTC
# j/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmCVgADsAW+iehp4LoJ7nvfam++Kctu
# 2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449xvNo32X2pFaq95W2KFUn0CS9QKC/
# GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wMnosZiefwC2qBwoEZQhlSdYo2wh3D
# YXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDSPeZKPmY7T7uG+jIa2Zb0j/aRAfbO
# xnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2dY3RILLFORy3BFARxv2T5JL5zbcqO
# Cb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxnGSgkujhLmm77IVRrakURR6nxt67I
# 6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+CrvsQWY9af3LwUFJfn6Tvsv4O+S3Fb+0
# zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokLjzbaukz5m/8K6TT4JDVnK+ANuOaM
# mdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNT
# TY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggLOMIICNwIBATCB+KGB0KSBzTCByjEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWlj
# cm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046N0JGMS1FM0VBLUI4MDgxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVAN/OE1C7xjU0ClIDXQBiucAY7suyoIGD
# MIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQG
# A1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwDQYJKoZIhvcNAQEF
# BQACBQDoSLjWMCIYDzIwMjMwNjMwMTAxMzQyWhgPMjAyMzA3MDExMDEzNDJaMHcw
# PQYKKwYBBAGEWQoEATEvMC0wCgIFAOhIuNYCAQAwCgIBAAICII0CAf8wBwIBAAIC
# EbUwCgIFAOhKClYCAQAwNgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoDAqAK
# MAgCAQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG9w0BAQUFAAOBgQC15ggjvDBy
# K1gB/ygX5NjNEK3pbvLuLFXZpxvXOFSNihUx3mCqrCarW6v4pVgHDzkLX7h95RCa
# 3GrnSU30v4FIxVijGPXnAE97ztVYtCjtBNVch48WqU+/1mD/EQF+rjxp2Hz2Vs5r
# Y2QEX4pgXWcJIe+sI+UZexWKxdn5BurknzGCBA0wggQJAgEBMIGTMHwxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29m
# dCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAByPmw7mft6mtGAAEAAAHIMA0GCWCG
# SAFlAwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJKoZI
# hvcNAQkEMSIEICm4updH9GXHIlyZcnen394KZj0CieBDqtdyeTVzQ31NMIH6Bgsq
# hkiG9w0BCRACLzGB6jCB5zCB5DCBvQQgYgCYz80/baMvxw6jcqSvL0FW4TdvA09n
# xHfsPhuEA2YwgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAIT
# MwAAAcj5sO5n7eprRgABAAAByDAiBCDtBAanrIeiN8nIznD0fKVx8Zlpmi94iYez
# LscCtgnPDjANBgkqhkiG9w0BAQsFAASCAgB10VBgUI7jHXA7gJNW27Badcqq/XCK
# iqEBSwmjPSpK7yn7OqlGefYDQ0KjXx9yn1SbiJ20N9fMxY28zYKffyjnIX2Uw7mK
# 9et4cUoxfEBZFsj7k3VZJYCnsMAYdSgrvu/ZQMDP5vGg7c17GCA7dRSH+Dn4vsYw
# lFo6mGXbLmxQ2fIpEh9IF6yokacmkuNS9CYcTTyAuOrJRvzoxh33/33Mb5zJbbvr
# wiqtbbmKcVl05v9apqWnykUmmwgxDoEbh/cMHA9cGzOCvzQwKmT3u4gAK5iSVhgC
# +sc+WZ1eGJHAQ3rP2kYrqNhzo9DQHc9QlBVpaESrxHVPl2aHdUW4q3rKJ0nk1aaa
# IwKHoLBNfYP1uj8WzPmHu+VXmRQKikI8s3Czyuc3P8yd1aGV1+DOaP2FB+3Hte6J
# FD7Y0vkXh9+DYhgM7UZEllCU1wX3Vf5Shg8YJXS0n7qxgjfMWM6BCgLVAPRD/ck+
# 8d36FHXn0aKCIix/K/b1R+yasNeS1r7UTKC0d7bKjxA/9+f2t9BiFjBHH+QUG3R+
# RqzNM59sUz5tDiv3uoTL7q4YKVq9FFyqzmt0YMtYEawT6kcRa/r3dzzzbwZC1Qf/
# VwHYORhHjpgLUOOm2+FAhYTmmBXHEDokktWebAhh11x527C7mlgpSaQh++Krra5B
# pi4BhuWQ4gz74g==
# SIG # End signature block
