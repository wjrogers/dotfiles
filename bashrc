# Check for an interactive session
[ -z "$PS1" ] && return

# launch tmux
if [ -z "$TMUX" ] && command -v tmux > /dev/null; then

    # fix SSH agent forwarding on re-attaching
    if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

    # ssh-pageant
    elif [ -x /usr/bin/ssh-pageant ]; then
        eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
    fi
    
    # wrap in ssh-agent if this is a local session
    if [ -z "$SSH_TTY" ] && command -v ssh-agent > /dev/null; then
        exec ssh-agent tmux new
    else
        exec tmux new -A -s auto
    fi
fi

# shell options
shopt -s checkwinsize
shopt -s histappend

# environment
export EDITOR=vim
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

# source the cygwin-specific stuff I guess?
CYGWIN_BASHRC=/etc/defaults/etc/skel/.bashrc
[ -e $CYGWIN_BASHRC ] && source $CYGWIN_BASHRC

# aliases
alias ls='ls -lh --color=auto'
