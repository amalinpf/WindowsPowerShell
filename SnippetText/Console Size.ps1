Return  # Don't execute accidentally

#buffer (otherwise e.g. columns are cut off on the right)
$buffer = $host.ui.RawUI.BufferSize; 
$buffer.width = 3000; 
$buffer.height = 3000; 
$host.UI.RawUI.Set_BufferSize($buffer)
