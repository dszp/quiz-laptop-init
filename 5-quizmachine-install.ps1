<#
Install QuizMachine. Put the QuizMachine installation file in the same folder as this script first. 
It should be the only .exe file that exists in this folder.
#>

# Get all .exe files in the current directory
$exeFiles = Get-ChildItem -Filter *.exe

# Check if any .exe files exist
if ($exeFiles.Count -eq 0) {
    Write-Error "Error: No .exe files found in the current directory."
    exit 1
} elseif ($exeFiles.Count -gt 1) {
    # Sort the .exe files alphabetically
    $exeFiles = $exeFiles | Sort-Object Name

    # List the .exe files with numbered prefixes
    Write-Host "Multiple Installer files found:"
    for ($i = 0; $i -lt $exeFiles.Count; $i++) {
        Write-Host "$($i + 1). $($exeFiles[$i].Name)"
    }

    # Prompt the user to choose a file
    $choice = Read-Host "Enter the number of the installer to run"

    # Validate the choice
    if ($choice -gt 0 -and $choice -le $exeFiles.Count) {
        $QM_installer = $exeFiles[$choice - 1].Name
        Write-Host "You selected: $QM_installer"
    } else {
        Write-Error "Invalid choice. Exiting."
        exit 1
    }
} else {
    # Only one .exe file exists
    $QM_installer = $exeFiles[0].Name
    Write-Host "Only one installer found file found: $QM_installer"
}
Write-Host "Silently installing the $QM_installer installation, please wait..."

Write-Host "When "QuizMachine Installed" prompt appears (may be behind window), click OK to finish." -ForegroundColor Yellow

Start-Process ".\$QM_installer" -ArgumentList "/S" -Wait

