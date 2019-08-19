Function Prompt {
  $Location = Get-Location
  $host.UI.RawUI.WindowTitle = $Location
  "PS $Location>"
}

# environment
$Env:FZF_DEFAULT_COMMAND = 'fd --type file --color=always --follow --hidden --exclude .git'
$Env:FZF_DEFAULT_OPTS = '--ansi --layout=reverse --border'

# PSFzf
Remove-PSReadlineKeyHandler 'Ctrl+r'
Import-Module PSFzf

# z.lua
$ZLuaPath = Join-Path $PSScriptRoot 'z.lua'
Invoke-Expression ($(lua $ZLuaPath --init powershell) -join "`n")

# z.lua -- customize and replace the default alias
Remove-Alias z
Function z { _zlua -I $Args }
Function zc { _zlua -I -c $Args }
Function zh { _zlua -I -t . }
