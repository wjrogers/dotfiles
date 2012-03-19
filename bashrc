# Check for an interactive session
[ -z "$PS1" ] && return

# source the cygwin-specific stuff I guess?
CYGWIN_BASHRC=/etc/defaults/etc/skel/.bashrc
[ -e $CYGWIN_BASHRC ] && source $CYGWIN_BASHRC

# aliases
alias ls='ls --color=auto'

# shell options
shopt -s checkwinsize
shopt -s histappend

# environment
export EDITOR=vim

# prompt
PROMPT='\[\e[0m\]\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'
PROMPT_COMMAND='history -a;printf "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
export PS1=$PROMPT
case ${TERM} in
    cygwin)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/$HOME/~}\007"'
        ;;
esac

# moar colors?
echo -ne '\e]P0353535\a'  # black
echo -ne '\e]P1AE4747\a'  # red
echo -ne '\e]P2556B2F\a'  # green
echo -ne '\e]P3DAA520\a'  # yellow
echo -ne '\e]P46F99B4\a'  # blue
echo -ne '\e]P58B7B8B\a'  # magenta
echo -ne '\e]P6A7A15E\a'  # cyan
echo -ne '\e]P7DDDDDD\a'  # white (light grey really)
echo -ne '\e]P8666666\a'  # bold black (i.e. dark grey)
echo -ne '\e]P9EE6363\a'  # bold red
echo -ne '\e]PA9ACD32\a'  # bold green
echo -ne '\e]PBFFC125\a'  # bold yellow
echo -ne '\e]PC7C96B0\a'  # bold blue
echo -ne '\e]PDD8BFD8\a'  # bold magenta
echo -ne '\e]PEF0E68C\a'  # bold cyan
echo -ne '\e]PFFFFFFF\a'  # bold white
