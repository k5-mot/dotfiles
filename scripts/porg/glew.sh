#!/usr/bin/env bash

## Install GLEW

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r glew
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/glew
cd $HOME/.local/src/

## Download
git clone https://github.com/nigels-com/glew.git
cd $HOME/.local/src/glew

## Install
export GLEW_VERSION=$(git tag | sed -e 's/glew-//g' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
make GLEW_DEST="$HOME/.local/usr" extensions
make GLEW_DEST="$HOME/.local/usr"
porg -lp  glew-${GLEW_VERSION} "make GLEW_DEST=$HOME/.local/usr install"
make clean

## Check
porg glew
cd $HOME
