$Base = "$HOME\.dotfiles"

if ($PSEdition -ne 'Core') {
    Write-Host "Install the pre-requisites from the Microsoft Store first."
    write-Host
    return
}

Write-Host "Installing dotfiles to $Base ..."
Write-Host

# Bootstrap scoop
if (-not (Get-Command scoop)) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    & scoop install git

    # Install a newer OpenSSH
    & scoop install win32-openssh

    # Install scoop apps
    $ScoopApps = Get-Content "$Base/Scoopfile"
    & scoop bucket add extras
    & scoop bucket add java
    & scoop bucket add versions
    & scoop install @ScoopApps
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

# Symlinks
$Links = @{
    "$Profile" = "$Base/powershell/Microsoft.PowerShell_profile.ps1"
    "$Env:APPDATA/mintty/config" = "$Base/mintty/config"
    "$Env:APPDATA/wsltty/config" = "$Base/mintty/config"
    "$HOME/.gitconfig" = "$Base/home/.gitconfig"
    "$HOME/.gvimrc" = "$Base/home/.gvimrc"
    "$HOME/.vimrc" = "$Base/home/.vimrc"
    "$HOME/.vim" = "$Base/home/.vim"
    "$HOME/vimfiles" = "$Base/home/.vim"
    "$Env:APPDATA/ConEmu.xml" = "$HOME/Dropbox/Applications/ConEmu.xml"
    "$HOME/.hyper.js" = "$HOME/Dropbox/.hyper.js"
    "$HOME/.vsvimrc" = "$Base/vsvimrc"
    "$Env:LOCALAPPDATA/nvim" = "$Base/home/.config/nvim"
}
foreach ($Source in $Links.Keys) {
    $Target = Resolve-Path $Links[$Source]
    New-Item -Force -ItemType SymbolicLink -Path "$Source" -Target "$Target"

    if ($LASTEXITCODE -ne 0) {
        throw "Try enabling Developer Mode in Windows Settings."
    }
}

# Environment -- Machine
$SystemPathBlocklist = @(
    "$($Env:SystemRoot)\System32\OpenSSH"
)
$SystemPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine").Split(";")
$SystemPathModified = $SystemPath | where { $SystemPathBlocklist -notcontains $_ }
$SystemPathItemsRemoved = $SystemPath | where { $SystemPathModified -notcontains $_ }
foreach ($item in $SystemPathItemsRemoved) {
    Write-Host "Please remove '$item' from the system PATH!"
}

# Environment (nulls delete old stuff if it's still around)
$Environment = @{
    "DOTFILES_HOME" = $Base
    "GITHUB_TOKEN" = $null
    "GITHUB_USER" = $null
    "GIT_SSH" = (Resolve-Path "$HOME/scoop/shims/ssh.exe")
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

# Done!
Write-Host "Bootstrapping complete."
Write-Host
