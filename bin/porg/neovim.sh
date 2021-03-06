#!/usr/bin/env bash

## neovim

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r neovim
fi
rm -rf $HOME/.local/src/neovim 
git clone https://github.com/neovim/neovim.git
cd $HOME/.local/src/neovim
rm -rf build/
git checkout stable
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/usr"
porg -lD make CMAKE_INSTALL_PREFIX=$HOME/.local/usr install
cd $HOME
