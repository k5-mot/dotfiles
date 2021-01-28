#!/usr/bin/env zsh

### Locale {{{
if false; then
  ## Basic locale
  export LANG="ja_JP.UTF-8"
  ## Translation priorities
  export LANGUAGE=
  ## Character types, their comparisons and classifications
  export LC_CTYPE="ja_JP.UTF-8"
  ## Number format
  export LC_NUMERIC="ja_JP.UTF-8"
  ## Date, time
  export LC_TIME="ja_JP.UTF-8"
  ## Collation and alignment of characters
  export LC_COLLATE="ja_JP.UTF-8"
  ## Currency
  export LC_MONETARY="ja_JP.UTF-8"
  ## Display message
  export LC_MESSAGES="ja_JP.UTF-8"
  ## Paper standard
  export LC_PAPER="ja_JP.UTF-8"
  ## Name
  export LC_NAME="ja_JP.UTF-8"
  ## Address
  export LC_ADDRESS="ja_JP.UTF-8"
  ## Telephone service
  export LC_TELEPHONE="ja_JP.UTF-8"
  ## Mesurement
  export LC_MEASUREMENT="ja_JP.UTF-8"
  ## Metadata
  export LC_IDENTIFICATION="ja_JP.UTF-8"
else
  ## All locale
  export LC_ALL="en_US.UTF-8"
fi
### }}}

### Environment variable {{{
## Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s
umask 022

## Term
export TERM="xterm-256color"
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
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export JSERVER="localhost"

## Initialize $PATH
export PATH
export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/libexec
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/libexec
export PATH=$PATH:/opt/bin
## Search path for the cd command
export CDPATH
#export CDPATH=$CDPATH:..
#export CDPATH=$CDPATH:~
#cdpath=(.. ~ ~/src ~/zsh)
## Search path for the man command
export MANPATH
export MANPATH=$MANPATH:/usr/share/man
export MANPATH=$MANPATH:/usr/local/share/man
export MANPATH=$MANPATH:/opt/share/man
## Search path for the info command
export MANPATH
export MANPATH=$MANPATH:/usr/share/info
export MANPATH=$MANPATH:/usr/local/share/info
export MANPATH=$MANPATH:/opt/share/info
## Directory for run-help function to find docs
export HELPDIR=/usr/local/lib/zsh/help
## xdgconfig
export XDG_CONFIG_HOME=$HOME/.config
## pdgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

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
### }}}

### Local Build Program {{{
## Set up environment variables for local build applications.
export LOCAL_ROOT=$HOME/.local
export PATH=$LOCAL_ROOT/bin:$PATH
export MANPATH=$LOCAL_ROOT/share/man:$MANPATH
export INFOPATH=$LOCAL_ROOT/share/info:$INFOPATH
export LD_LIBRARY_PATH=$LOCAL_ROOT/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_ROOT/lib64:$LD_LIBRARY_PATH
## Set up GNU environment variables for local build applications.
export CPATH=$LOCAL_ROOT/include:$CPATH
export C_INCLUDE_PATH=$LOCAL_ROOT/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$LOCAL_ROOT/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=$LOCAL_ROOT/lib:$LIBRARY_PATH
export LIBRARY_PATH=$LOCAL_ROOT/lib64:$LIBRARY_PATH
### }}}
export NVIM_PYTHON_LOG_FILE=$HOME/.cache/nvim/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

## Set up local PATH.
if [ -e $HOME/.zshenv_local ]; then
  source $HOME/.zshenv_local
fi

# Set up scripts of dotfiles.
export FPATH=$FPATH:$HOME/dotfiles/bin
export FPATH=$FPATH:$HOME/dotfiles/bin/local

## automatically remove duplicates from these arrays
typeset -U path PATH
typeset -U cdpath cdpath
typeset -U fpath FPATH
typeset -U manpath MANPATH
typeset -U infopath INFOPATH
