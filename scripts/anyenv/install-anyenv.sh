#!/usr/bin/env bash

set -eu

## Configure anyenv variable
export ANYENV_ROOT=$HOME/.anyenv

## Download anyenv
if [ ! -e $ANYENV_ROOT ]; then
  git clone --verbose --progress https://github.com/anyenv/anyenv $ANYENV_ROOT
fi
cd $ANYENV_ROOT
git pull
cd $HOME

## Set up anyenv.
if [ -e $ANYENV_ROOT ]; then
  export PATH=$ANYENV_ROOT/bin:$PATH
  if command -v anyenv 1>/dev/null 2>&1
  then
    eval "$(anyenv init -)"
  fi
  export ANYENV_PLUGINS=$ANYENV_ROOT/plugins
  mkdir -p $ANYENV_PLUGINS
  if [ ! -e $ANYENV_PLUGINS/anyenv-update ]; then
    git clone --verbose --progress https://github.com/znz/anyenv-update.git $ANYENV_PLUGINS/anyenv-update
  fi
  if [ ! -e $ANYENV_PLUGINS/anyenv-git ]; then
    git clone --verbose --progress https://github.com/znz/anyenv-git.git $ANYENV_PLUGINS/anyenv-git
  fi
fi

## Check version.
anyenv --version
anyenv install --list

## Set up pyenv, rbenv & nodenv.


anyenv install --skip-existing nodenv
anyenv install --skip-existing luaenv
anyenv install --skip-existing plenv
