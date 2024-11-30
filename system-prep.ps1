# Disable Fastboot
# /v is the REG_DWORD /t Specifies the type of registry entries /d Specifies the data for the new entry /f Adds or deletes registry content without prompting for confirmation.
 
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d "0" /f

# Harden Windows Registry
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Harden-Security-Windows-Registry.ps1")

# Disable PowerShell 2 for security
iex (irm "https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Disable-PowerShell-V2.ps1")