# Paste this script into an Administrative PowerShell prompt to start system prep and copy scripts locally:

& Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
iex (irm "https://raw.githubusercontent.com/dszp/quiz-laptop-init/refs/heads/main/system-prep.ps1")

<#
After this script runs successfully, you should be able to launch an Administrative PowerShell 
Prompt and type:

cd ~/quizsetup
dir

This will list the files that can be run locally to finish setup processes.
Run each file with a dot-backslash in front (tab-complete works), like:

.\dcu-install-update.ps1

To update the files, while inside the directory, type:

git pull
#>
