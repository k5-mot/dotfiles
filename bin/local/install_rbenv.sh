#!/bin/bash

## Install rbenv
## Setup rbenv
## Install basic packages by gem

## Configure rbenv variable
export RBENV_RUBY_VERSION=$(rbenv install --list-all | grep -v '[a-zA-Z]' | grep -e '[0-9]\.[0-9]\.[0-9]' | tail -1)
#export RBENV_RUBY_VERSION=2.7.2
export RBENV_ROOT=$HOME/.rbenv
export RBENV_PLUGINS=$RBENV_ROOT/plugins

## Install rbenv
if [ ! -e $RBENV_ROOT ]; then
  git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT
fi
cd $RBENV_ROOT
git pull

## Install ruby-build
if [ ! -e $RBENV_PLUGINS/ruby-build ]; then
  git clone https://github.com/sstephenson/ruby-build.git $RBENV_PLUGINS/ruby-build
fi
cd $RBENV_PLUGINS/ruby-build
git pull

## Install rbenv-update
if [ ! -e $RBENV_PLUGINS/rbenv-update ]; then
  git clone https://github.com/rkh/rbenv-update.git $RBENV_PLUGINS/rbenv-update
fi
cd $RBENV_PLUGINS/rbenv-update
git pull

## Setup rbenv
cd $HOME
export RBENV_ROOT=$HOME/.rbenv
export PATH=$RBENV_ROOT/bin:$PATH
eval "$(rbenv init -)"
#$RBENV_ROOT/bin/rbenv init

## Install Ruby
rbenv install $RBENV_RUBY_VERSION
rbenv rehash

## Install packages of Ruby
rbenv global $RBENV_RUBY_VERSION
gem update
gem install neovim

## Download rbenv-doctor script
mkdir $RBENV_ROOT/scripts
cd $RBENV_ROOT/scripts
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

