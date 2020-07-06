# Check for an interactive session
[ -z "$PS1" ] && return

# work around https://github.com/mintty/wsltty/issues/197
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  command -v cmd.exe > /dev/null || return
fi

# shell options
shopt -s checkwinsize
shopt -s histappend

# homebrew -- source once before starting tmux
test -d ~/.linuxbrew && BREW='~/.linuxbrew/bin/brew'
test -d /home/linuxbrew/.linuxbrew && BREW='/home/linuxbrew/.linuxbrew/bin/brew'
if command -v $BREW > /dev/null && ! command -v brew > /dev/null; then
  eval $($BREW shellenv)
fi

# launch tmux
if \
  [ -z "$TMUX" ] && \
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

  # don't auto-attach local sessions
  if [ -z "$SSH_TTY" ]; then
    exec tmux new
  else
    exec tmux new -A -s auto
  fi
fi

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

# environment we don't want to leak through from Windows
unset GIT_SSH

# prompt
HISTCONTROL='ignorespace:erasedups'
HISTFILESIZE=2000
HISTIGNORE='ls:git status:tig*'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
PS1='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# z.lua
Z_LUA_PATH=~/.dotfiles/z.lua
if command -v lua > /dev/null && [ -f $Z_LUA_PATH ]; then
  eval "$(lua $Z_LUA_PATH --init bash enhanced once fzf)"
fi

# completions
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  for COMPLETION in "$HOMEBREW_PREFIX/etc/bash_completion.d/"*; do
    [[ -r "$COMPLETION" ]] && source "$COMPLETION"
  done
fi

# aliases
alias ls='exa -l'
alias rg='rg -S'
alias z='_zlua -I'
alias zc='_zlua -I -c'
alias zh='_zlua -I -t .'

# source custom local configuration
[ -e ~/.bashrc.local ] && source ~/.bashrc.local
