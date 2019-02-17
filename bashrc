# Check for an interactive session
[ -z "$PS1" ] && return

# launch tmux
if [ -z "$TMUX" ] && command -v tmux > /dev/null; then

    # fix SSH agent forwarding on re-attaching
    if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

    # ssh-agent-wsl
    elif command -v ~/.ssh/ssh-agent-wsl > /dev/null; then
        eval $(~/.ssh/ssh-agent-wsl -r)

    # ssh-pageant
    elif [ -x /usr/bin/ssh-pageant ]; then
        eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
    
    # wrap in ssh-agent if this is a local session
    elif [ -z "$SSH_TTY" ] && command -v ssh-agent > /dev/null; then
        exec ssh-agent tmux new
    fi

    # don't auto-attach local sessions
    if [ -z "$SSH_TTY" ]; then
        exec tmux new
    else
        exec tmux new -A -s auto
    fi
fi

# shell options
shopt -s checkwinsize
shopt -s histappend

# environment
export EDITOR=vim

# environment we don't want to leak through from Windows
unset GIT_SSH

# prompt
PROMPT='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
export PS1=$PROMPT
case ${TERM} in
    cygwin)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/$HOME/~}\007"'
        ;;
esac

# source the cygwin-specific stuff I guess?
CYGWIN_BASHRC=/etc/defaults/etc/skel/.bashrc
[ -e $CYGWIN_BASHRC ] && source $CYGWIN_BASHRC

# aliases
alias ls='ls -lh --color=auto'

# pyenv
if command -v "$HOME/.pyenv/bin/pyenv" > /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source custom local configuration
[ -e ~/.bashrc.local ] && source ~/.bashrc.local
