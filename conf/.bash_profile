
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

## Initialize $PATH
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/bin
export PATH=$PATH:/usr/games
export PATH=$PATH:/usr/local/games
export PATH=$PATH:/opt/bin

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lib

export CPATH=$CPATH:/usr/local/include
export CPATH=$CPATH:/usr/include
export CPATH=$CPATH:/opt/include

## Search path for the cd command
#export CDPATH=$CDPATH:..
#export CDPATH=$CDPATH:~
## Search path for the man command
export MANPATH=$MANPATH:/usr/local/share/man
export MANPATH=$MANPATH:/usr/share/man
export MANPATH=$MANPATH:/opt/share/man
## Search path for the info command
export INFOPATH=$INFOPATH:/usr/local/share/info
export INFOPATH=$INFOPATH:/usr/share/info
export INFOPATH=$INFOPATH:/opt/share/info
## Directory for run-help function to find docs
export HELPDIR=$HELPDIR:/usr/local/lib/zsh/help
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
export LESS_TERMCAP_mb=$(printf "\e[1;33m")
export LESS_TERMCAP_md=$(printf "\e[1;36m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")
### }}}

### Local Build Program {{{
## Set up environment variables for local build applications.
export LOCAL_ROOT=$HOME/.local
export PATH=$LOCAL_ROOT/usr/bin:$PATH
export LD_LIBRARY_PATH=$LOCAL_ROOT/usr/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_ROOT/usr/lib:$LD_LIBRARY_PATH
export MANPATH=$LOCAL_ROOT/usr/share/man:$MANPATH
export INFOPATH=$LOCAL_ROOT/usr/share/info:$INFOPATH
export CPATH=$LOCAL_ROOT/usr/include:$CPATH
### }}}
export NVIM_PYTHON_LOG_FILE=$HOME/.cache/nvim/nvim_python.log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

## Set up homebrew
if [ $OSTYPE = linux-gnu -o $OSTYPE = linux ]; then
  export HOMEBREW_ROOT=$HOME/.linuxbrew
  if [ -e $HOMEBREW_ROOT ]; then
    export PATH=$HOMEBREW_ROOT/sbin:$PATH
    export PATH=$HOMEBREW_ROOT/bin:$PATH
    export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
    export INFOPATH=$HOMEBREW_ROOT/share/info:$INFOPATH
    export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib64:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib:$LD_LIBRARY_PATH
    export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS
    # Optional
    export HOMEBREW_NO_ENV_FILTERING=1
    export HOMEBREW_DEVELOPER=1
    export HOMEBREW_CURL_PATH=$HOME/.local/usr/bin/curl
    export HOMEBREW_GIT_PATH=$HOME/.local/usr/bin/git

    eval "$($HOMEBREW_ROOT/bin/brew shellenv)"
  fi
fi

### Programming environament {{{
## Set up anyenv.
export ANYENV_ROOT=$HOME/.anyenv
if [ -e $ANYENV_ROOT ]; then
  export PATH="$ANYENV_ROOT/bin:$PATH"
  if command -v anyenv 1>/dev/null 2>&1; then
    eval "$(anyenv init -)"
    for D in `ls $HOME/.anyenv/envs`
    do
      export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
  fi
fi

## Set up rust.
export CARGO_ROOT=$HOME/.cargo
if [ -e $CARGO_ROOT ]; then
  #source $CARGO_ROOT/env
  export PATH=$CARGO_ROOT/bin:$PATH
fi

## Set up golang.
export GOPATH=$HOME/.golang
if [ -e $GOPATH ]; then
  export PATH=$GOPATH/bin:$PATH
fi

## Setup VcXsrv for WSL
if [ "$(uname 2> /dev/null)" = Linux ]; then
  if [[ "$(uname -r 2> /dev/null)" = *microsoft* ]]; then
    export LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    export DISPLAY=$LOCAL_IP:0
    export LIBGL_ALWAYS_INDIRECT=1
    export WIN_USERNAME=$(powershell.exe '$env:USERNAME' | sed -e 's///g')
    export WIN_USERHOME=/mnt/c/Users/$WIN_USERNAME
    export WIN_USERDESK=$WIN_USERHOME/Desktop
  fi
fi
# Set up scripts of dotfiles.
export PATH=$PATH:$(find $HOME/.config/scripts -type d | xargs echo | sed -e 's/ /:/g')

## Set
export LIBRARY_PATH=$LIBRARY_PATH:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$C_INCLUDE_PATH:$CPATH
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CPATH
export CPLUS_INCLUDE_PATH="/usr/include/c++/$(ls -1 /usr/include/c++ | tail -1 | sed 's/[@\/]//')":$CPLUS_INCLUDE_PATH
