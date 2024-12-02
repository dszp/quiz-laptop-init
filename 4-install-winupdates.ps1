# ABOUT: Installs Windows Updates that are available using PowerShell. Run from Administrative Command Prompt.
# Will prompt to reboot if necessary, but will not reboot automatically.
# Reboot and re-run until no updates are installed.

# SOURCE: https://learn.microsoft.com/en-us/answers/questions/1613848/update-and-restart-from-powershell-or-command-line
# (comment)

function Test-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if(!(Test-IsElevated)) {
    Write-Host "This script needs to be run with elevated permissions, from an Administrative PowerShell prompt. Exiting..."
    exit 1
}

# necessary to import-module and use get-windowsupdate, reverts to system settings after powershell closes
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

# this gets the windows update package provider
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# by setting the psgallery to trusted before installing the module, it avoids a dialog
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

# here's the meat
Install-Module PSWindowsUpdate
Import-Module PSWindowsUpdate
Get-WindowsUpdate | Format-Table
Install-WindowsUpdate -AcceptAll -Install
