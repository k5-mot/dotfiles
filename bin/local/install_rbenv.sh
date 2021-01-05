#!/bin/bash

## Install rbenv
## Setup rbenv
## Install basic packages by gem

## Configure rbenv variable
export RBENV_RUBY_VERSION=2.7.2
export RBENV_ROOT=$HOME/.rbenv
export RBENV_PLUGINS=$RBENV_ROOT/plugins

## Install rbenv
git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT
cd $RBENV_ROOT
git pull

## Install ruby-build
git clone https://github.com/sstephenson/ruby-build.git $RBENV_PLUGINS/ruby-build
cd $RBENV_PLUGINS/ruby-build
git pull

## Install rbenv-update
git clone https://github.com/rkh/rbenv-update.git $RBENV_PLUGINS/rbenv-update
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

