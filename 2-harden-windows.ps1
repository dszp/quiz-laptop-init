function Test-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if(!(Test-IsElevated)) {
    Write-Host "This script needs to be run with elevated permissions, from an Administrative PowerShell prompt. Exiting..." -ForegroundColor Red
    exit 1
}

# Harden Windows Registry
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Harden-Security-Windows-Registry.ps1" -Verbose:$false)

# Disable PowerShell 2 for security
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Disable-PowerShell-V2.ps1")
