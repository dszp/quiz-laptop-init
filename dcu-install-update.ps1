# Install Dell Command Update and Update System

## SOURCE: https://garytown.com/dell-command-update-install-manage-via-powershell

[CmdletBinding()]
param(
    [switch] $Install
)

iex (irm dell.garytown.com)
Install-DCU
Get-DCUVersion

if($Install) {
    $DCU_ExitCode = Invoke-DCU -reboot 'Enable' -applyUpdates 
    if($DCU_ExitCode -eq 0) {
        Write-Host "`n`nUpdates successful, no reboot required."
    } elseif ($DCU_ExitCode -eq 500) {
        Write-Host "`n`nNo updates available to install, quitting." 
    } else { 
        Write-Host "`n`nUpdates successful, reboot required, so rebooting in 5 seconds."
        Start-Sleep -Seconds 5
        Restart-Computer -Force
    } 
} else {
    Invoke-DCU -reboot 'Enable' -scan
    Write-Host "`n`nRe-run script with -Install flag to install available updates after scan."
}
