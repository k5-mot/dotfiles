# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;36m\]\w \[\033[01;32m\]\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.config/.dircolors && eval "$(dircolors -b ~/.config/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls -CF --color=auto'
  alias ll='ls -alF --color=auto'
  alias la='ls -A --color=auto'
  alias lla='ls -la --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -CF'
  alias ll='ls -alF'
  alias la='ls -A'
  alias lla='ls -la'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias x=exit
alias wget='wget --hsts-file $HOME/.cache/wget/wget-hsts'
alias xsel='xsel --logfile=$HOME/.cache/xsel/xsel.log'
alias osinfo='cat /etc/*-release'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#function path_append() {
#  path_remove $1;
#  export PATH="$PATH:$1";
#}
#
#function path_prepend() {
#  path_remove $1;
#  export PATH="$1:$PATH";
#}
#
#function path_remove() {
#  export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`;
#}
#
## check powerline
#function check_powerline() {
#  echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
#}
#
## check 256 colors v1
#function check_colors() {
#  for c in {000..255}; do
#    #echo -n "\e[[30;48;5${c}m\e[[38;5;${((255 - %c))}m $c\e[[0m"
#    echo -n "\e[31;48;5;${c}m\e[38;5;${$((255 - $c))}m $c \e[0m"
#    if [ $(($c % 16)) -eq 15 ]; then
#      echo
#    fi
#    #[ $(($c%16)) -eq 15 ] && echo
#  done
#  echo
#}
#
## Check path.
#function check_path() {
#  echo "PATH"
#  echo $PATH | sed -e "s/:/\n/g"
#}
#
## Check library path.
#function check_libpath() {
#  echo "LD_LIBRARY_PATH"
#  echo $LD_LIBRARY_PATH | sed -e 's/:/\n/g'
#  echo "LIBRARY_PATH"
#  echo $LIBRARY_PATH | sed -e 's/:/\n/g'
#}
#
## Check include path
#function check_includepath() {
#  echo "CPATH"
#  echo $CPATH | sed -e 's/:/\n/g'
#  echo "C_INCLUDE_PATH"
#  echo $C_INCLUDE_PATH | sed -e 's/:/\n/g'
#  echo "CPLUS_INCLUDE_PATH"
#  echo $CPLUS_INCLUDE_PATH | sed -e 's/:/\n/g'
#}
#
## check 256 colors v2
#function check_colors1() {
#  awk 'BEGIN{
#    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
#    for (colnum = 0; colnum<77; colnum++) {
#      r = 255-(colnum*255/76);
#      g = (colnum*510/76);
#      b = (colnum*255/76);
#      if (g>255) g = 510-g;
#        printf "\033[48;2;%d;%d;%dm", r,g,b;
#        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
#        printf "%s\033[0m", substr(s,colnum+1,1);
#      }
#    printf "\n";
#  }'
#}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#if [ -f ~/.bash_aliases ]; then
#  . ~/.bash_aliases
#fi

# read local file
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

