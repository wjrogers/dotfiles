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
    screen)
        PROMPT_COMMAND='history -a;echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
        export PS1=$PROMPT_FANCY
        ;;
    cygwin)
        PROMPT_COMMAND='history -a;echo -ne "\033]0;${PWD/$HOME/~}\007"'
        export PS1=$PROMPT_PLAIN
        ;;
esac
