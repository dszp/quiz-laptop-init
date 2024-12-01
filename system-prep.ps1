# Disable Fastboot
Write-Host "Disabling FastBoot via registry key..."
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d "0" /f

# Disable sleep and standby when on AC power:
Write-Host "Disabling sleep and standby when on AC power..."
Powercfg /Change monitor-timeout-ac 0
Powercfg /Change standby-timeout-ac 0

#Install-Script winget-install -Force
#winget-install
powershell "&([ScriptBlock]::Create((irm winget.pro))) -Force"

# Uncomment to install Dell Command Update via WinGet:
# winget install -e --id Dell.CommandUpdate --accept-package-agreements --accept-source-agreements --silent
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements --silent

# Reload path after install:
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

if(!(Test-Path -Path "~\quizsetup")) {
    Write-Host "Creating quizsetup directory..."
    New-Item -Path "~\quizsetup" -ItemType Directory
}
Change-Directory -Path "~\quizsetup"
git clone 'https://github.com/dszp/quiz-laptop-init.git' .

# Run in an Administrative PowerShell prompt manually against a specific file, this unblocks downloaded files to execute:
Unblock-File *.ps1

# Harden Windows Registry
powershell "&([ScriptBlock]::Create((irm 'https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Harden-Security-Windows-Registry.ps1' -Verbose:$false)))"

# Disable PowerShell 2 for security
powershell "&([ScriptBlock]::Create((irm 'https://raw.githubusercontent.com/dszp/MSP-Scripts/refs/heads/main/Windows-Security-Hardening/Disable-PowerShell-V2.ps1')))"
