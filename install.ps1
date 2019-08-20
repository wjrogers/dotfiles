$Base = "$HOME\dotfiles"

Write-Host "Installing dotfiles to $Base ..."
Write-Host

# Bootstrap scoop
if (-not (Get-Command scoop)) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    & scoop install git pwsh
}

# Bootstrap this repository
if (-not (Test-Path $Base)) {
    & git clone https://github.com/wjrogers/dotfiles.git "$Base"
    & git -C "$Base" submodule update --init
    & git -C "$Base" remote set-url origin git@github.com:wjrogers/dotfiles.git 
}

# Configure OpenSSH Agent
$AgentService = Get-Service ssh-agent
if ($AgentService -and $AgentService.StartType -ne 'Automatic') {
    Start-Process powershell.exe -Verb RunAs -Wait -ArgumentList @"
-Command & {
    Set-Service ssh-agent -StartupType Automatic
    Start-Service ssh-agent -PassThru | Format-List *
    pause
}
"@
}
$AgentService = $null

# Switch to PowerShell Core
if ($PSEdition -ne 'Core') {
    Write-Host "Bootstrapping complete."
    Write-Host
    Write-Host "Run the remainder of this script in PowerShell Core:"
    Write-Host "  $(scoop which pwsh) $PSCommandPath"
    Write-Host
    return
}

# Install scoop apps
$ScoopApps = Get-Content "$Base/Scoopfile"
& scoop bucket add extras
& scoop bucket add java
& scoop bucket add versions
& scoop install @ScoopApps

# Symlinks
$Links = @{
    "$Profile" = "$Base/powershell/Microsoft.PowerShell_profile.ps1"
    "$Env:APPDATA/mintty/config" = "$Base/mintty/config"
    "$HOME/.gitconfig" = "$Base/home/.gitconfig"
    "$HOME/.vimrc" = "$Base/home/.vimrc"
    "$HOME/.vim" = "$Base/home/.vim"
    "$HOME/vimfiles" = "$Base/home/.vim"
    "$Env:APPDATA/ConEmu.xml" = "$HOME/Dropbox/Applications/ConEmu.xml"
    "$HOME/.hyper.js" = "$HOME/Dropbox/.hyper.js"
}
foreach ($Source in $Links.Keys) {
    $Target = Resolve-Path $Links[$Source]
    New-Item -Force -ItemType SymbolicLink -Path "$Source" -Target "$Target"

    if ($LASTEXITCODE -ne 0) {
        throw "Try enabling Developer Mode in Windows Settings."
    }
}

# Environment (nulls delete old stuff if it's still around)
$Environment = @{
    "GITHUB_TOKEN" = $null
    "GITHUB_USER" = $null
    "GIT_SSH" = (Resolve-Path (& where.exe ssh))
    "HOME" = $null
    "HTML_TIDY" = (Resolve-Path "$Base/home/.tidyrc")
    "TERM" = $null
}
foreach ($Key in $Environment.Keys) {
    $Value = $Environment[$Key]
    [System.Environment]::SetEnvironmentVariable($Key, $Value, "User")
    Set-Item "Env:$Key" "$Value"
}

# Modules
Install-Module -Scope CurrentUser PSFzf
