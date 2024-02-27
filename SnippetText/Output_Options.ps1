Return  # Don't execute accidentally

$OutFile = ".\Output\OUTFILE.csv"       # or .txt

[Console]::BufferWidth = 4096       # Avoid line wrapping

Export-csv -path $OutFile   # -Append -Delimiter ';' -NoTypeInformation
$result | Out-File $OutFile -Append

Format-Wide
Format-List -Property id,[field2,field3...]
Format-Table [-field,[field2,field3...]] [-AutoSize] [-Wrap]                # Also Group, Sort, etc.
Out-GridView [-Passthru]

Write-Output    # or ECHO       https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-string-substitutions?view=powershell-7.3
    <# Can pipe to other commands, use -NoEnumerate to pass as a single object
    Doesn't need quotes, words on separate lines
    If in quotes, all on one line 
    Output variable name within DOUBLE quotes to contatenate with string    "The value is $var"
    Surround string with @"MultipleLines"@ for multiple lines
    #>

Write-Host      # Send to output stream, stdout (default to console)
<# Puts space between elements
-noNewLine -separator -foregroundcolor -backgroundcolor
write-host $one $two -separator ''  # concat variables use -separator of empty string #>
