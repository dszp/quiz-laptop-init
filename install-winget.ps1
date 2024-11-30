#Install-Script winget-install -Force
#winget-install
&([ScriptBlock]::Create((irm winget.pro))) -Force

# Uncomment to install Dell Command Update via WinGet:
# winget install -e --id Dell.CommandUpdate --accept-package-agreements --accept-source-agreements --silent

# Upgrade all installed apps with WinGet:
winget upgrade --all --accept-package-agreements --silent --include-pinned
