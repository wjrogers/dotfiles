Function Prompt {
  $savedLastExitCode = $LASTEXITCODE

  $Location = Get-Location
  $host.UI.RawUI.WindowTitle = $Location

  # handle z.lua history ourselves to preserve LASTEXITCODE
  if ($global:_zlua_inited) {
    _zlua --update
  }

  $LASTEXITCODE = $savedLastExitCode
  "PS $Location>"
}

# environment
$Env:FZF_DEFAULT_COMMAND = 'fd --type file --color=always --follow --hidden --exclude .git'
$Env:FZF_DEFAULT_OPTS = '--ansi --layout=reverse --border'
$Env:_ZL_NO_PROMPT_COMMAND = $true

# PSFzf
Remove-PSReadlineKeyHandler 'Ctrl+r'
Import-Module PSFzf

# z.lua
if (Test-Path "$Env:DOTFILES_HOME/z.lua") {
  Invoke-Expression ($(lua "$Env:DOTFILES_HOME/z.lua" --init powershell) -join "`n")

  # z.lua -- customize and replace the default alias
  Remove-Alias z
  Function z { _zlua -I $Args }
  Function zc { _zlua -I -c $Args }
  Function zh { _zlua -I -t . }
}
