# Paste this script into an Administrative PowerShell prompt to start system prep and copy scripts locally:

& Set-Execution-Policy -ExecutionPolicy Unrestricted
iex (irm "https://raw.githubusercontent.com/dszp/quiz-laptop-init/refs/heads/main/system-prep.ps1")
