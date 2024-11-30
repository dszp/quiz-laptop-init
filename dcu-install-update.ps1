# Install Dell Command Update and Update System

## SOURCE: https://garytown.com/dell-command-update-install-manage-via-powershell

iex (irm dell.garytown.com)
Install-DCU
Invoke-DCU -reboot 'Enable' -scan
# Invoke-DCU -reboot 'Enable' -applyUpdates
