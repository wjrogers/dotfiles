Function Prompt {
  $Location = Get-Location
  $host.UI.RawUI.WindowTitle = $Location
  "PS $Location>"
}

# UTF-8 encoding!
[console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# environment
if (Get-Command "nvim" -ErrorAction Ignore) {
  $Env:EDITOR = "nvim"
}
$Env:FZF_DEFAULT_COMMAND = 'fd --type file --color=always --follow --hidden --exclude .git'
$Env:FZF_DEFAULT_OPTS = '--ansi'
$Env:FZF_CTRL_T_COMMAND = $Env:FZF_DEFAULT_COMMAND

# PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# zoxide
if (Get-Command "zoxide" -ErrorAction Ignore) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
