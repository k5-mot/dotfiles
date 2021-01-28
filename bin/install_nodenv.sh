#!/bin/bash

## Install nodenv
## Setup nodenv
## Install basic packages by npm

## Configure nodenv variable
export NODENV_NODEJS_VERSION=$(nodenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]\.[0-9]\.[0-9]' | tail -1)
#export NODENV_NODEJS_VERSION=15.1.0
export NODENV_ROOT=$HOME/.nodenv
export NODENV_PLUGINS=$NODENV_ROOT/plugins

## Install nodenv
if [ ! -e $NODENV_ROOT ]; then
  git clone https://github.com/nodenv/nodenv.git $NODENV_ROOT
fi
cd $NODENV_ROOT
git pull

## Install node-build
if [ ! -e $NODENV_PLUGINS/node-build ]; then
  git clone https://github.com/nodenv/node-build.git $NODENV_PLUGINS/node-build
fi
cd $NODENV_PLUGINS/node-build
git pull

## Install nodenv-update
if [ ! -e $NODENV_PLUGINS/nodenv-update ]; then
  git clone https://github.com/nodenv/nodenv-update.git $NODENV_PLUGINS/nodenv-update
fi
cd $NODENV_PLUGINS/nodenv-update
git pull

## Install nodenv-packages-rehash
if [ ! -e $NODENV_PLUGINS/nodenv-package-rehash ]; then
  git clone https://github.com/nodenv/nodenv-package-rehash.git $NODENV_PLUGINS/nodenv-package-rehash
fi
cd $NODENV_PLUGINS/nodenv-package-rehash
git pull

## Setup nodenv
cd $HOME
export NODENV_ROOT=$HOME/.nodenv
export PATH=$NODENV_ROOT/bin:$PATH
eval "$(nodenv init -)"
#$NODENV_ROOT/bin/nodenv init

## Install node.js
nodenv install $NODENV_NODEJS_VERSION
nodenv rehash

## Install packages of Node.js
nodenv global $NODENV_NODEJS_VERSION
nodenv rehash
npm install --global neovim
nodenv rehash

