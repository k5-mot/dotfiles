#!/usr/bin/env zsh

### Locale {{{
## Basic locale
export LANG="en_US.UTF-8"
## Translation priorities
export LANGUAGE="en_US"
### Character types, their comparisons and classifications
#export LC_CTYPE="en_US.UTF-8"
### Number format
#export LC_NUMERIC="en_US.UTF-8"
### Date, time
#export LC_TIME="en_US.UTF-8"
### Collation and alignment of characters
#export LC_COLLATE="en_US.UTF-8"
### Currency
#export LC_MONETARY="en_US.UTF-8"
### Display message
#export LC_MESSAGES="en_US.UTF-8"
### Paper standard
#export LC_PAPER="en_US.UTF-8"
### Name
#export LC_NAME="en_US.UTF-8"
### Address
#export LC_ADDRESS="en_US.UTF-8"
### Telephone service
#export LC_TELEPHONE="en_US.UTF-8"
### Mesurement
#export LC_MEASUREMENT="en_US.UTF-8"
### Metadata
#export LC_IDENTIFICATION="en_US.UTF-8"
## All locale
export LC_ALL="en_US.UTF-8"
#export LC_ALL="ja_JP.UTF-8"
### }}}

### Environment variable {{{
## Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s
umask 022

## Term
#export TERM="xterm-256color"
export TERM="screen-256color"
## Default editor
if command -v nvim 1>/dev/null 2>&1; then
  export EDITOR="nvim"
elif command -v vim 1>/dev/null 2>&1; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi
## Default pager
if command -v vimpager 1>/dev/null 2>&1; then
  export PAGER="vimpager"
  export MANPAGER="vimpager"
else
  export PAGER="less -iMR"
  export MANPAGER="less -iMR"
fi

## Stop alert of mail check by zsh.
export MAILCHECK=0
## Stack of history by changing directory.
export DIRSTACKSIZE=20
## enviroment variables
export JSERVER="localhost"
#export TMUX_ACS="utf8"
#export TMUX_ACS="acs"
#export TMUX_ACS="ascii"

## Initialize $PATH
#export PATH
#export PATH=$PATH:/snap/bin
#export PATH=$PATH:/usr/local/sbin
#export PATH=$PATH:/usr/local/bin
#export PATH=$PATH:/usr/sbin
#export PATH=$PATH:/usr/bin
#export PATH=$PATH:/sbin
#export PATH=$PATH:/bin
#export PATH=$PATH:/usr/games
#export PATH=$PATH:/usr/local/games
#export PATH=$PATH:/opt/bin
#
#export LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lib64
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lib
#
#export CPATH
#export CPATH=$CPATH:/usr/local/include
#export CPATH=$CPATH:/usr/include
#export CPATH=$CPATH:/opt/include
#
### Search path for the cd command
#export CDPATH
##export CDPATH=$CDPATH:..
##export CDPATH=$CDPATH:~
### Search path for the man command
#export MANPATH
#export MANPATH=$MANPATH:/usr/local/share/man
#export MANPATH=$MANPATH:/usr/share/man
#export MANPATH=$MANPATH:/opt/share/man
### Search path for the info command
#export INFOPATH
#export INFOPATH=$INFOPATH:/usr/local/share/info
#export INFOPATH=$INFOPATH:/usr/share/info
#export INFOPATH=$INFOPATH:/opt/share/info
### Directory for run-help function to find docs
#export HELPDIR=$HELPDIR:/usr/local/lib/zsh/help
### xdgconfig
#export XDG_CONFIG_HOME=$HOME/.config
### pdgconfig
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

## Settings of less
export LESSCHARSET=utf-8
export LESS="-iMR"
export MANPAGER="less -iMR"
# Colorize man command.
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;33m") \
        LESS_TERMCAP_md=$(printf "\e[1;36m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}
export LESS_TERMCAP_mb=$(printf "\e[1;33m")
export LESS_TERMCAP_md=$(printf "\e[1;36m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")
### }}}

export NVIM_PYTHON_LOG_FILE=$HOME/.cache/nvim/nvim_python.log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

## Setup VcXsrv for WSL
if [ "$(uname 2> /dev/null)" = Linux ]; then
  if [[ "$(uname -r 2> /dev/null)" = *microsoft* ]]; then
    export LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    export DISPLAY=$LOCAL_IP:0
    export LIBGL_ALWAYS_INDIRECT=1
    #export WIN_USERNAME=$(powershell.exe '$env:USERNAME' | sed -e 's///g')
    #export WIN_USERHOME=/mnt/c/Users/$WIN_USERNAME
    #export WIN_USERDESK=$WIN_USERHOME/Desktop
  fi
fi

## Set up anyenv.
#if [ -e "$HOME/.anyenv" ]; then
#  export ANYENV_ROOT="$HOME/.anyenv"
#  export PATH="$ANYENV_ROOT/bin:$PATH"
#fi

## Set up local PATH.
if [ -e $HOME/.zshenv_local ]; then
  source $HOME/.zshenv_local
fi

# Set up scripts of dotfiles.
export PATH=$PATH:$(find $HOME/.config/scripts -type d | xargs echo | sed -e 's/ /:/g')

## Set
#export FPATH
#export LIBRARY_PATH
#export LIBRARY_PATH=$LIBRARY_PATH:$LD_LIBRARY_PATH
#export C_INCLUDE_PATH
#export C_INCLUDE_PATH=$C_INCLUDE_PATH:$CPATH
#export CPLUS_INCLUDE_PATH
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CPATH
#if [ -d "/usr/include/c++" ]; then
#  export CPLUS_INCLUDE_PATH="/usr/include/c++/$(ls -1 /usr/include/c++ | tail -1 | sed 's/[@\/]//')":$CPLUS_INCLUDE_PATH
#fi

### Local Build Program {{{
## Set up environment variables for local build applications.
export LOCAL_ROOT=$HOME/.local
export PATH=$LOCAL_ROOT/usr/bin:$PATH
export LD_LIBRARY_PATH=$LOCAL_ROOT/usr/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_ROOT/usr/lib:$LD_LIBRARY_PATH
export MANPATH=$LOCAL_ROOT/usr/share/man:$MANPATH
export INFOPATH=$LOCAL_ROOT/usr/share/info:$INFOPATH
export CPATH=$LOCAL_ROOT/usr/include:$CPATH
if [ -e "$LOCAL_ROOT/usr/include/c++" ]; then
  export CPLUS_INCLUDE_PATH="$LOCAL_ROOT/usr/include/c++/$(ls -1 $LOCAL_ROOT/usr/include/c++ | tail -1 | sed 's/[@\/]//')":$CPLUS_INCLUDE_PATH
fi
### }}}

## automatically remove duplicates from these arrays
typeset -U path PATH
typeset -U cdpath CDPATH
typeset -U fpath FPATH
typeset -U manpath MANPATH
typeset -U infopath INFOPATH

typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
typeset -T LIBRARY_PATH library_path
typeset -U library_path
typeset -T CPATH cpath
typeset -U cpath
typeset -T C_INCLUDE_PATH c_include_path
typeset -U c_include_path
typeset -T CPLUS_INCLUDE_PATH cplus_include_path
typeset -U cplus_include_path

