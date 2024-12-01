#Install-Script winget-install -Force
#winget-install
# SOURCE: https://github.com/asheroto/winget-install
powershell "&([ScriptBlock]::Create((irm winget.pro))) -Force"

# Uncomment to install Dell Command Update via WinGet:
# winget install -e --id Dell.CommandUpdate --accept-package-agreements --accept-source-agreements --silent
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements --silent

# Reload path after install:
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

mkdir ~/quizsetup
cd ~/quizsetup
git clone https://github.com/dszp/quiz-laptop-init.git .
