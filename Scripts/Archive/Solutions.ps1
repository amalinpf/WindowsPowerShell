<#
Add-SPSolution -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.CommonUtils.wsp"
Add-SPSolution -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.NITROStudio.wsp"
Add-SPSolution -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.WorkflowManager.wsp"

update-SPSolution -identity crowcanyon.commonutils.wsp -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.CommonUtils.wsp" -gacdeployment
update-SPSolution -identity crowcanyon.NITROStudio.wsp -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.NITROStudio.wsp" -gacdeployment
update-SPSolution -identity crowcanyon.WorkflowManager.wsp -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.WorkflowManager.wsp" -gacdeployment


uninstall-SPSolution -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.CommonUtils.wsp"
remove-SPSolution -LiteralPath "C:\Program Files\Crow Canyon\NITRO Studio\SP2016\CrowCanyon.CommonUtils.wsp"
#>