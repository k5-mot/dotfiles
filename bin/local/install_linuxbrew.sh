#!/bin/bash
export HOMEBREW_NO_ENV_FILTERING=1
export HOMEBREW_DEVELOPER=1
export HOMEBREW_CURL_PATH=$HOME/.local/bin/curl
export HOMEBREW_GIT_PATH=$HOME/.local/bin/git
if [ ! -d $HOME/.linuxbrew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
$HOME/.linuxbrew/bin/brew shellenv
#export HOMEBREW_ROOT=$HOME/.linuxbrew
#export PATH=$HOMEBREW_ROOT/bin:$PATH
#export PATH=$HOMEBREW_ROOT/sbin:$PATH
#export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
#export INFOPATH=$HOMEBREW_ROOT/share/info:$INFOPATH
#export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib:$LD_LIBRARY_PATH
$HOME/.linuxbrew/bin/brew doctor
