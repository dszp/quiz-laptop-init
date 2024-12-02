# Disable Fastboot
Write-Host "Disabling FastBoot via registry key..."
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d "0" /f

# Disable sleep and standby when on AC power:
Write-Host "Disabling sleep and standby when on AC power..."
Powercfg /Change monitor-timeout-ac 0
Powercfg /Change standby-timeout-ac 0

#Install-Script winget-install -Force
#winget-install
Write-Host "Installing WinGet"
powershell "&([ScriptBlock]::Create((irm winget.pro))) -Force"

Write-Host "Installing Git and Dell Command Update if applicable..."

winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements --silent
if((Get-CimInstance -ClassName Win32_OperatingSystem).Manufacturer -like "*Dell*") {
    winget install -e --id Dell.CommandUpdate --accept-package-agreements --accept-source-agreements --silent
}
winget install -e --id Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements --silent

Write-Host "Reloading system path after install to make new apps available..."
# Reload path after install:
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "Creating $($env:USERPROFILE)\quizsetup directory and cloning quiz-laptop-init repository with git..." -ForegroundColor Green
if(!(Test-Path -Path "~\quizsetup")) {
    Write-Host "Creating quizsetup directory because it doesn't exist yet..."
    New-Item -Path "~\quizsetup" -ItemType Directory
}
Set-Location -Path "~\quizsetup"
git clone 'https://github.com/dszp/quiz-laptop-init.git' .

# Run in an Administrative PowerShell prompt manually against a specific file, this unblocks downloaded files to execute:
Unblock-File *.ps1

Write-Host "To return to this directory in an Administrative PowerShell window in the future, type: cd ~\quizsetup"
Write-Host "The security hardening and Dell Command Update (if Dell computer) are the next important scripts to run."
Write-Host "Only run the appropriate Windows Feature Update script if not yet at Windows Pro 22H2 or later in the System properties."
Write-Host "To update to the latest setup file, while in this directory type: git pull"

Write-Host "`nThe following documentation file for reference are in the $($env:USERPROFILE)\quizsetup directory:`n" -ForegroundColor Green
Get-ChildItem -Filter *.md | ForEach-Object { Write-Host $_.Name }

Write-Host "`nThe following script are in the $($env:USERPROFILE)\quizsetup directory:`n" -ForegroundColor Green
Get-ChildItem -Filter *.ps1 | 
    Where-Object { $_.Name -notlike 'INACTIVE*' } | 
    Sort-Object Name | 
    ForEach-Object { Write-Host $_.Name }

Write-Host "`nRun the scripts starting with 2-harden-windows.ps1 and so forth, some multiple times if needed." -ForegroundColor Green
