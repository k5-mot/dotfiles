#!/usr/bin/env bash

## Install GLFW

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r glfw
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/glfw
cd $HOME/.local/src/

## Download
git clone https://github.com/glfw/glfw.git
cd $HOME/.local/src/glfw

## Install
export GLFW_VERSION=$(git tag | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
mkdir build
cd build/
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local/usr .. 
make
porg -lp glfw-${GLFW_VERSION} "make install"

## Check
porg glfw
cd $HOME
