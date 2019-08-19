$Base = $PSScriptRoot

# Symlinks
$Links = @{
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
}

# Environment (nulls delete old stuff if it's still around)
$Environment = @{
    "GITHUB_TOKEN" = $null
    "GITHUB_USER" = $null
    "HOME" = $null
    "HTML_TIDY" = (Resolve-Path "$Base/home/.tidyrc")
    "TERM" = $null
}
foreach ($Key in $Environment.Keys) {
    $Value = $Environment[$Key]
    [System.Environment]::SetEnvironmentVariable($Key, $Value, "User")
    Set-Item "Env:$Key" "$Value"
}
