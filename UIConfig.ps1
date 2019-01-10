$Shell = $Host.UI.RawUI
$Shell.WindowTitle="Chuck's Powershell"

$size = $Shell.WindowSize
$size.width=120
$size.height=30
$Shell.WindowSize = $size
$size = $Shell.BufferSize
$size.width=70
$size.height=5000
$Shell.BufferSize = $size

$Shell.backgroundcolor = "Black"
$Shell.foregroundcolor = "Green"
$colors = $host.privatedata
$colors.verbosebackgroundcolor = "Black"
$colors.verboseforegroundcolor = "Magenta"
$colors.warningbackgroundcolor = "Black"
$colors.warningforegroundcolor = "Yellow"
$colors.ErrorBackgroundColor = "Black"
$colors.ErrorForegroundColor = "Red"

Clear-Host