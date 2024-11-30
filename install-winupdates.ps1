# SOURCE: https://learn.microsoft.com/en-us/answers/questions/1613848/update-and-restart-from-powershell-or-command-line
# (comment)

# necessary to import-module and use get-windowsupdate, reverts to system settings after powershell closes
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

# this gets the windows update package provider
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# by setting the psgallery to trusted before installing the module, it avoids a dialog
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

# here's the meat
Install-Module PSWindowsUpdate
Import-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -Install
