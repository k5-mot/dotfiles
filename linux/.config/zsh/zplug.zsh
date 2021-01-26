#!/usr/bin/env zsh
## Install directory
export ZPLUG_HOME=$ZDOTCACHE/zplug

## Install zplug
if [[ ! -e $ZPLUG_HOME ]];then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
## Initialize zplug
source $ZPLUG_HOME/init.zsh

## Plugin list
zplug "zplug/zplug", hook-build:"zplug --self-manage"

## Syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2
## History search
zplug "zsh-users/zsh-history-substring-search"
## Type completion
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

## Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

## Then, source plugins and add commands to $PATH
#zplug load --verbose
zplug load

# zsh-completions
export FPATH=$FPATH:$ZPLUG_HOME/repos/zsh-users/zsh-completions/src
export FPATH=$FPATH:$ZDOTDIR/completion
#fpath=($ZPLUG_HOME/repos/zsh-users/zsh-completions/src $ZDOTDIR/completion "${fpath[@]}")
