# Check for an interactive session
[ -z "$PS1" ] && return

# shell options
shopt -s checkwinsize
shopt -s cmdhist
shopt -s globstar 2> /dev/null
shopt -s histappend
shopt -s nocaseglob

# prevent redirects clobbering existing files (use '>|' to override)
set -o noclobber

# keychain
if command -v keychain > /dev/null; then
  eval `keychain --eval --agents ssh --inherit any-once`
fi

# ls colors
[ -f ~/.dir_colors ] && eval $(dircolors ~/.dir_colors)

# environment
export EDITOR=vim
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# environment we don't want to leak through from Windows
unset GIT_SSH

# prompt
HISTCONTROL='erasedups:ignoreboth'
HISTFILESIZE=2000
HISTIGNORE='ls:git status:tig*'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
PS1='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'

# cargo (rustup) -- must run early so later checks work
[ -f ~/.cargo/env ] && source ~/.cargo/env

# broot
[ -e ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# zoxide
if command -v zoxide > /dev/null; then
  eval "$(zoxide init bash)"
fi

# completions
if command -v aws_completer > /dev/null; then
  complete -C aws_completer aws
fi
if command -v kubectl > /dev/null; then
  eval "$(kubectl completion bash)"
fi
if command -v terraform > /dev/null; then
  complete -C terraform terraform tf
fi

# aliases
[ -x "$(command -v lsd)" ] && alias ls='lsd -l'
alias la='ls -a'
alias rg='rg -S'
alias tf='terraform'

# starship go
[ -x "$(command -v starship)" ] && eval "$(starship init bash)"

# source custom local configuration
[ -e ~/.bashrc.local ] && source ~/.bashrc.local
