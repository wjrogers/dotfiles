# Check for an interactive session
[ -z "$PS1" ] && return

# shell options
shopt -s checkwinsize
shopt -s histappend

# ssh-pageant
if [ -x /usr/bin/ssh-pageant ]; then
    eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
fi

# fix SSH agent forwarding on re-attaching to tmux
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

# for local sessions, start ssh-agent if we don't seem to have one
if [[ -z "$SSH_TTY" && ! -S ~/.ssh/ssh_auth_sock ]]; then
    eval $(ssh-agent -s)
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

# environment
export EDITOR=vim
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
eval `dircolors ~/.dir_colors`

# base16-shell
BASE16_SHELL=~/.dotfiles/base16-shell/
[ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# prompt
PROMPT='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
export PS1=$PROMPT
case ${TERM} in
    cygwin)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/$HOME/~}\007"'
        ;;
esac

# launch tmux if it is installed
if command -v tmux > /dev/null && [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
    if tmux ls; then
        exec tmux attach
    else
        exec tmux
    fi
fi

# source the cygwin-specific stuff I guess?
CYGWIN_BASHRC=/etc/defaults/etc/skel/.bashrc
[ -e $CYGWIN_BASHRC ] && source $CYGWIN_BASHRC

# aliases
alias ls='ls -lh --color=auto'
