# Check for an interactive session
[ -z "$PS1" ] && return

# source the cygwin-specific stuff I guess?
CYGWIN_BASHRC=/etc/defaults/etc/skel/.bashrc
[ -e $CYGWIN_BASHRC ] && source $CYGWIN_BASHRC

# aliases
alias ls='ls --color=auto'

# shell options
shopt -s histappend
bind TAB:menu-complete

# prompt
PROMPT_FANCY='\n\[\e[38;5;162m\]\u \[\e[38;5;15m\]on \[\e[38;5;214m\]\h \[\e[38;5;15m\]in \[\e[38;5;118m\]\w\n\[\e[38;5;15m\]$ \[\e[0m\]'
PROMPT_PLAIN='\n\[\e[1;32m\]\w \[\e[1;37m\]$ \[\e[0m\]'
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        export PS1=$PROMPT_FANCY
        ;;
    screen*)
        PROMPT_COMMAND='history -a;echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
        export PS1=$PROMPT_FANCY
        ;;
    cygwin)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/$HOME/~}\007"'
        export PS1=$PROMPT_PLAIN
        ;;
esac

# colors?
echo -ne '\e]10;#DDDDDD\a'  # Black foreground
echo -ne '\e]11;#121212\a'  # Light gray background
echo -ne '\e]12;#00FF00\a'  # Green cursor

# moar colors?
echo -ne '\e]4;0;#353535\a'   # black
echo -ne '\e]4;1;#AE4747\a'   # red
echo -ne '\e]4;2;#556B2F\a'   # green
echo -ne '\e]4;3;#DAA520\a'   # yellow
echo -ne '\e]4;4;#6F99B4\a'   # blue
echo -ne '\e]4;5;#8B7B8B\a'   # magenta
echo -ne '\e]4;6;#A7A15E\a'   # cyan
echo -ne '\e]4;7;#DDDDDD\a'   # white (light grey really)
echo -ne '\e]4;8;#666666\a'   # bold black (i.e. dark grey)
echo -ne '\e]4;9;#EE6363\a'   # bold red
echo -ne '\e]4;10;#9ACD32\a'  # bold green
echo -ne '\e]4;11;#FFC125\a'  # bold yellow
echo -ne '\e]4;12;#7C96B0\a'  # bold blue
echo -ne '\e]4;13;#D8BFD8\a'  # bold magenta
echo -ne '\e]4;14;#F0E68C\a'  # bold cyan
echo -ne '\e]4;15;#FFFFFF\a'  # bold white
