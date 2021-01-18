## Set up basis environment variables.
unset os_type
unset ar_type
export PATH=/bin
#export PATH=$PATH:/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/opt/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export EDITOR=vim
export PAGER=less

# Set up scripts of dotfiles.
export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:$HOME/dotfiles/bin/local

## Set up anyenv.
if [ $OSTYPE = linux-gnu -o $OSTYPE = linux ]; then

  ## Set up local build applications.
  export LOCAL_ROOT=$HOME/.local
  export PATH=$LOCAL_ROOT/bin:$PATH
  export PATH=$LOCAL_ROOT/scripts:$PATH
  export MANPATH=$LOCAL_ROOT/share/man:$MANPATH
  export INFOPATH=$LOCAL_ROOT/share/info:$INFOPATH
  export LD_LIBRARY_PATH=$LOCAL_ROOT/lib:$LD_LIBRARY_PATH
  export LD_LIBRARY_PATH=$LOCAL_ROOT/lib64:$LD_LIBRARY_PATH

  ## Set up GNU environment variables.
  #export CPATH=$CPATH:$HOME/include
  #export C_INCLUDE_PATH=$C_INCLUDE_PATH:
  #export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:
  #export LIBRARY_PATH=$LIBRARY_PATH:$HOME/lib
  #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib

  ## Set up homebrew
  if [ -e "$HOME/.linuxbrew" ]; then
    export HOMEBREW_ROOT=$HOME/.linuxbrew
    export PATH=$HOMEBREW_ROOT/bin:$PATH
    #export PATH=$HOMEBREW_ROOT/sbin:$PATH
    #export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
    #export INFOPATH=$HOMEBREW_ROOT/share/info:$INFOPATH
    #export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib:$LD_LIBRARY_PATH
    export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS
    ## Optional
    export HOMEBREW_NO_ENV_FILTERING=1
    export HOMEBREW_DEVELOPER=1
    export HOMEBREW_CURL_PATH=$HOME/.local/bin/curl
    export HOMEBREW_GIT_PATH=$HOME/.local/bin/git
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
  fi

  ## Set up anyenv.
  if [ -e "$HOME/.anyenv" ]; then
    export ANYENV_ROOT=$HOME/.anyenv
    export PATH=$ANYENV_ROOT/bin:$PATH
    if command -v anyenv 1>/dev/null 2>&1; then
      eval "$(anyenv init -)"
    fi
  fi

  ## Set up pyenv
  # if [ -e "$HOME/.pyenv" ]; then
  #   export PYENV_ROOT=$HOME/.pyenv
  #   export PATH=$PYENV_ROOT/bin:$PATH
  #   if command -v pyenv 1>/dev/null 2>&1; then
  #     eval "$(pyenv init -)"
  #     eval "$(pyenv virtualenv-init -)"
  #   fi
  # fi

  # ## Set up rbenv
  # if [ -e "$HOME/.rbenv" ]; then
  #   export RBENV_ROOT=$HOME/.rbenv
  #   export PATH=$RBENV_ROOT/bin:$PATH
  #   if command -v rbenv 1>/dev/null 2>&1; then
  #     eval "$(rbenv init -)"
  #   fi
  # fi

  # ## Set up nodenv
  # if [ -e "$HOME/.nodenv" ]; then
  #   export NODENV_ROOT=$HOME/.nodenv
  #   export PATH=$NODENV_ROOT/bin:$PATH
  #   if command -v nodenv 1>/dev/null 2>&1; then
  #     eval "$(nodenv init -)"
  #   fi
  # fi

fi

## Set up local PATH.
if [ -e $HOME/.zshenv_local ]; then
  source $HOME/.zshenv_local
fi

## Delete duplicated path.
typeset -U path PATH
