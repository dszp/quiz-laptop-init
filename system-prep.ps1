<# system-prep.ps1
ABOUT: Prepares a Windows 10 computer with a fresh Windows installation to run several scripts for updating and Windows hardening to 
prepare a Windows 10 computer for running QuizMachine. Installs the WinGet Microsoft Windows Package Manager first. Uses that to 
install Dell CommandUpdate if computer is Dell, and installs Windows Terminal. 
Installs Git and creates a ~\quizsetup directory and clones the quiz-laptop-init repository into it to provide additional scripts 
to run locally to finish the setup process.
The .md files in the repository (and folder) are listed, they contain help information. Then the .ps1 files in the repository are 
listed, unless they start with INACTIVE which means they're for reference or a work-in-progress. See directions and output after 
this script runs.

See the "1-manual-bootstrap-commands.ps1" script for how to run this script by copying and pasting the URL to the script into an 
Administrative PowerShell prompt.
#>
# -Help and -Update switches are equivalent
[CmdletBinding()]
param(
    [switch] $Update,
    [switch] $Help
)

$github_repo_url = "https://github.com/dszp/quiz-laptop-init.git"

function Test-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if(!(Test-IsElevated)) {
    Write-Host "This script needs to be run with elevated permissions, from an Administrative PowerShell prompt. Exiting..." -ForegroundColor Red
    exit 1
}

function Initial-Setup-Install-Clone {
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
    if((Get-CimInstance -Query 'Select * from Win32_BIOS').Manufacturer -like "*Dell*") {
        winget install -e --id Dell.CommandUpdate --accept-package-agreements --accept-source-agreements --silent
    }
    winget install -e --id Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements --silent

    Write-Host "Reloading system path after install to make new apps available..."
    # Reload path after install:
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Complete-Setup-And-Help {
    Write-Host "Creating $($env:USERPROFILE)\quizsetup directory and cloning quiz-laptop-init repository with git..." -ForegroundColor Green
    if(!(Test-Path -Path "$($env:USERPROFILE)\quizsetup" -ErrorAction SilentlyContinue)) {
        Write-Host "Creating quizsetup directory because it doesn't exist yet..."
        New-Item -Path "$($env:USERPROFILE)\quizsetup" -ItemType Directory
    }
    Set-Location -Path "$($env:USERPROFILE)\quizsetup"

    # Clone the repository
    # git clone $($github_repo_url).git .

    # Check if the current folder is a git repository
    if (Test-Path -Path ".git" -PathType Container) {
        Write-Host "This directory is already a git repository. Performing git pull to refresh source scripts..."
        git pull
    } else {
        Write-Host "This directory is not yet a git repository. Cloning from $github_repo_url..."
        git clone $github_repo_url .
    }

    # Run in an Administrative PowerShell prompt manually against a specific file, this unblocks downloaded files to execute:
    Unblock-File *.ps1

    Write-Host "To return to this directory in an Administrative PowerShell window in the future, type: cd ~\quizsetup" -ForegroundColor Yellow
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
}

if(!$Help -and !$Update) {
    Initial-Setup-Install-Clone
}
Complete-Setup-And-Help

Write-Host "To update to the latest scripts and re-print the above help only, pass the -Help switch to this script in the future."
Write-Host "(This will skip the WinGet and package installations.)"
