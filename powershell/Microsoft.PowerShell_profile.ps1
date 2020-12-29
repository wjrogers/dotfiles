Function Prompt {
  $Location = Get-Location
  $host.UI.RawUI.WindowTitle = $Location
  "PS $Location>"
}

# environment
$Env:FZF_DEFAULT_COMMAND = 'fd --type file --color=always --follow --hidden --exclude .git'
$Env:FZF_DEFAULT_OPTS = '--ansi --layout=reverse --height 40%'

# PSFzf
Remove-PSReadlineKeyHandler 'Ctrl+r'
Import-Module PSFzf

# zoxide
if (Get-Command "zoxide" -ErrorAction SilentlyContinue) {
  Invoke-Expression ($(zoxide init --hook "pwd" powershell) -join "`n")
}
