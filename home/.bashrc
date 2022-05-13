# homebrew -- source once before starting tmux
test -d ~/.linuxbrew && BREW='~/.linuxbrew/bin/brew'
test -d /home/linuxbrew/.linuxbrew && BREW='/home/linuxbrew/.linuxbrew/bin/brew'
if command -v $BREW > /dev/null && ! command -v brew > /dev/null; then
  eval $($BREW shellenv)
fi

# Check for an interactive session
[ -z "$PS1" ] && return

# launch tmux
if \
  [ -z "$TMUX" ] && \
  [ -z "$TMUX_NO_AUTOEXEC" ] && \
  [[ ! "$WSLENV" =~ "VSCODE" ]] && \
  command -v tmux > /dev/null; \
then

  # fix SSH agent forwarding on re-attaching
  if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

  # wsl-ssh-agent (:
  elif [ -n ${WSL_AUTH_SOCK} ]; then
    export SSH_AUTH_SOCK=${WSL_AUTH_SOCK}
  fi

  # start a new tmux server for local sessions
  if [ -z "$SSH_TTY" ]; then
    exec tmux new
  else
    exec tmux new -A -s auto
  fi
fi

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
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--ansi --height 40% --layout=reverse'
export FZF_ALT_C_COMMAND='fd --type d --color=always --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX=1

# environment we don't want to leak through from Windows
unset GIT_SSH

# prompt
HISTCONTROL='erasedups:ignoreboth'
HISTFILESIZE=2000
HISTIGNORE='ls:git status:tig*'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
PS1='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# zoxide
if command -v zoxide > /dev/null; then
  eval "$(zoxide init bash)"
fi

# completions
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  for COMPLETION in "$HOMEBREW_PREFIX/etc/bash_completion.d/"*; do
    [[ -r "$COMPLETION" ]] && source "$COMPLETION"
  done
fi
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
alias ls='exa -l'
alias rg='rg -S'
alias tf='terraform'

# source custom local configuration
[ -e ~/.bashrc.local ] && source ~/.bashrc.local
