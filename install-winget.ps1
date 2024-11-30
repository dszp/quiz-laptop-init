#Install-Script winget-install -Force
#winget-install
&([ScriptBlock]::Create((irm winget.pro))) -Force
winget install -e --id Dell.CommandUpdate --accept-package-agreements --accept-source-agreements --silent
