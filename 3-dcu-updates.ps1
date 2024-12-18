# Install Dell Command Update and Update System

## SOURCE: https://garytown.com/dell-command-update-install-manage-via-powershell

[CmdletBinding()]
param(
    [switch] $Scan
)

function Test-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if(!(Test-IsElevated)) {
    Write-Host "This script needs to be run with elevated permissions, from an Administrative PowerShell prompt. Exiting..." -ForegroundColor Red
    exit 1
}

iex (irm dell.garytown.com)
# The install function doesn't work, but WinGet is used to install Dell CommandUpdate from system-prep.ps1.
# Install-DCU
Get-DCUVersion

if(!$Scan) {
    Write-Host "`n`nScanning for Dell updates and installing any it finds. Will automatically reboot if necessary." -ForegroundColor Yellow
    Write-Host "(Run this script with -Scan flag to show but not install available updates after scan.)"
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
    Write-Host "`n`n(Run this script with -Scan flag to show but not install available updates after scan.)"
}
