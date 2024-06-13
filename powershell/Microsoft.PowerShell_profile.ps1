Function Prompt {
  $Location = Get-Location
  $host.UI.RawUI.WindowTitle = $Location
  "PS $Location>"
}

# UTF-8 encoding!
[console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# environment
$Env:FZF_DEFAULT_COMMAND = 'fd --type file --color=always --follow --hidden --exclude .git'
$Env:FZF_DEFAULT_OPTS = '--ansi --layout=reverse --height 40%'

# PSFzf
Remove-PSReadlineKeyHandler 'Ctrl+r'
Import-Module PSFzf

# zoxide
if (Get-Command "zoxide" -ErrorAction Ignore) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
