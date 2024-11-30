# Install Dell Command Update and Update System

## SOURCE: https://garytown.com/dell-command-update-install-manage-via-powershell

[CmdletBinding()]
param(
    [switch] $Install
)

iex (irm dell.garytown.com)
Install-DCU
Get-DCUVersion

Invoke-DCU -reboot 'Enable' -scan

if($Install) {
    Invoke-DCU -reboot 'Enable' -applyUpdates
} else {
    Write-Host "`n`nRe-run script with -Install flag to install available updates after scan."
}
