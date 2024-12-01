# Harden Windows Registry
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Harden-Security-Windows-Registry.ps1" -Verbose:$false)

# Disable PowerShell 2 for security
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Disable-PowerShell-V2.ps1")
