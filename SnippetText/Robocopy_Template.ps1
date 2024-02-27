Return  # Don't execute accidentally

# Generates Robocopy command
$source = ""  # Ex. "\\amalin-pc\c$\Users\amalin\OneDrive - postfallsidaho.org\Documents\SPFx"
$dest = ""    # Ex. "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\SPFx"     same subfolder if desired

$log = "C:\Users\amalin\OneDrive - postfallsidaho.org\Documents\WindowsPowerShell\Scripts\Logs\Robocopy.log"
$xDir = ""			#Space separated
$xFile = "*tmp*"	#Space separated
$cmd = "robocopy.exe `"$source`" `"$dest`" /E /MT /r:1 /w:1 /reg /xd $xDir /xf $xFile /Log+:`"$Log`" /FP"

#Do it
cmd.exe /c $cmd
