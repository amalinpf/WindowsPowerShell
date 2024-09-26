Return  # Don't execute accidentally

# For better performance in some cases, especially with many values, use see ForEach() method

$InFile = ".\Input\INFILE.csv"      # or .txt

# LIST OF VALUES
$servers = @('sharepoint-svr','sharepoint-dev','hypervspdev-svr')

# TEXT FILE WITH ONE VALUE PER LINE:
$servers = Get-Content $InFile

# CSV FILE WITH ONE VALUE PER LINE, column names in first row:
Import-Csv $InFile | ForEach-Object {
	Write-Output "$($_.Column_Name)"
	# Other Stuff
}

# DYNAMIC COLLECTION
$servers = {something that returns a collection of server names}
    foreach ($server in $servers) {
    Write-Output $server
    # or other code
    }

################## ALSO SEE ITERATE SNIPPET(S)
