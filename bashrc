# Check for an interactive session
[ -z "$PS1" ] && return

# shell options
shopt -s checkwinsize
shopt -s histappend

# fix SSH agent forwarding on re-attaching to tmux
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

# environment
export EDITOR=vim
eval `dircolors ~/.dir_colors`

# prompt
PROMPT='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
export PS1=$PROMPT
case ${TERM} in
    cygwin)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/$HOME/~}\007"'
        ;;
esac

# solarized dark
echo -ne '\e]P0073642\a'  # black
echo -ne '\e]P1dc322f\a'  # red
echo -ne '\e]P2859900\a'  # green
echo -ne '\e]P3b58900\a'  # yellow
echo -ne '\e]P4268bd2\a'  # blue
echo -ne '\e]P5d33682\a'  # magenta
echo -ne '\e]P62aa198\a'  # cyan
echo -ne '\e]P7eee8d5\a'  # white (light grey really)
echo -ne '\e]P8002b36\a'  # bold black (i.e. dark grey)
echo -ne '\e]P9cb4b16\a'  # bold red
echo -ne '\e]PA586e75\a'  # bold green
echo -ne '\e]PB657b83\a'  # bold yellow
echo -ne '\e]PC839496\a'  # bold blue
echo -ne '\e]PD6c71c4\a'  # bold magenta
echo -ne '\e]PE93a1a1\a'  # bold cyan
echo -ne '\e]PFfdf6e3\a'  # bold white

# will this work in putty? probably not
echo -ne '\e]10;#839496\a'  # foreground
echo -ne '\e]11;#002b36\a'  # background
echo -ne '\e]12;#859900\a'  # cursor

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
