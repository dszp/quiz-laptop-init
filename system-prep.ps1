# Disable Fastboot
# /v is the REG_DWORD /t Specifies the type of registry entries /d Specifies the data for the new entry /f Adds or deletes registry content without prompting for confirmation.

Write-Host "Disabling FastBoot via registry key."
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d "0" /f

# Disable sleep and standby when on AC power:
Write-Host "Disabling sleep and standby when on AC power."
Powercfg /Change monitor-timeout-ac 0
Powercfg /Change standby-timeout-ac 0

# Harden Windows Registry
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Harden-Security-Windows-Registry.ps1")

# Disable PowerShell 2 for security
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Disable-PowerShell-V2.ps1")
