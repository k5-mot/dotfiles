#!/bin/bash

## Install nodenv
## Setup nodenv
## Install basic packages by npm

## Configure nodenv variable
export NODENV_NODEJS_VERSION=15.1.0
export NODENV_ROOT=$HOME/.nodenv
export NODENV_PLUGINS=$NODENV_ROOT/plugins

## Install nodenv
git clone https://github.com/nodenv/nodenv.git $NODENV_ROOT
cd $NODENV_ROOT
git pull

## Install node-build
git clone https://github.com/nodenv/node-build.git $NODENV_PLUGINS/node-build
cd $NODENV_PLUGINS/node-build
git pull

## Install nodenv-update
git clone https://github.com/nodenv/nodenv-update.git $NODENV_PLUGINS/nodenv-update
cd $NODENV_PLUGINS/nodenv-update
git pull

## Install nodenv-packages-rehash
git clone https://github.com/nodenv/nodenv-package-rehash.git $NODENV_PLUGINS/nodenv-package-rehash
cd $NODENV_PLUGINS/nodenv-package-rehash
git pull

## Setup nodenv
cd $HOME
$NODENV_ROOT/bin/nodenv init

## Install node.js
nodenv install $NODENV_NODEJS_VERSION
nodenv rehash

## Install packages of Node.js
nodenv global $NODENV_NODEJS_VERSION
nodenv rehash
npm install --global neovim
nodenv rehash
