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
    if((Invoke-DCU -reboot 'Enable' -applyUpdates) -eq 0) {
        Write-Host "`n`nUpdates successful, no reboot required."
    } else {
        Write-Host "`n`nUpdates successful, reboot required, so rebooting in 5 seconds."
        Start-Sleep -Seconds 5
        Restart-Computer -Force
    } 
} else {
    Write-Host "`n`nRe-run script with -Install flag to install available updates after scan."
}
