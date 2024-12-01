# How to Foce-Install Windows Feature Version Updates for Windows 10

Windows 10 feature updates are not always discovered via Windows Update immediately. But we can force them to be installed using a couple of techniques, one of which is specific to older versions of Windows 10 (21H1 or older) and the other works with 21H2 or newer. The earlier version script installs at time of writing, 22H2. The newer version script also explicitly installs 22H2, but can be called with -23H2 to upgrade to 23H2 instead (run this one if the system is already at 21H2 or later).

At time of writing, 22H2 is the recommended latest verison as 23H2 had some issues on first release.

The scripts will likely look like they are DOING NOTHING. They WILL reboot if they install either update, and they may provide a countdown (maybe even 20 minutes on the older one) but may not. As long as one of the scripts is running and hasn't failed, you should leave it alone and do nothing else on the system until it completes and reboots. It may take over an hour depending on the system!

You should run Windows Updates (manually or via script) after the update installs and reboots, repeatedly until no more are left.

Run the scripts from an Administrative PowerShell prompt.

## I want to update an earlier Windows 10 version to 22H2
`.\Invoke-FeatureUpdate-21H1-or-older-Windows10UpdateWithUpdateAssistant.ps1`

## I want to update Windows 10 21H2 or 22H2 to 23H2
`.\Invoke-FeatureUpdate-21H2-or-newer-Windows10UpdateWithEnablementPackage.ps1`

The local script targets installing 22H2 by default. To install 23H2, pass the `-23H2` parameter.

## Credit/sources
The original scripts are at https://github.com/homotechsual/Blog-Scripts/tree/main/Update%20Management

The pre-21H2 version original script: https://github.com/homotechsual/Blog-Scripts/blob/main/Update%20Management/Invoke-Windows10UpdateWithUpdateAssistant.ps1

The 21H2 or newer version original script: https://github.com/homotechsual/Blog-Scripts/blob/main/Update%20Management/Invoke-Windows10UpdateWithEnablementPackage.ps1