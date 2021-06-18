#!/usr/bin/env bash

## neovim

# Change dir
cd $HOME
cd $HOME/.local/src

# Remove package
if (type "porg" > /dev/null 2>&1); then
  porg -r neovim
fi
rm -rf $HOME/.local/src/neovim

# Download package
git clone https://github.com/neovim/neovim.git
cd $HOME/.local/src/neovim
#mkdir -pv neovim
#https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
#tar -zxvf nvim-linux64.tar.gz
#mv nvim-linux64/bin/nvim /usr/local/bin

# Install package
git checkout stable
rm -rf build/
CC=$HOME/.local/usr/bin/gcc CMAKE=$HOME/.local/usr/bin/cmake make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/usr"
export NEOVIM_VERSION=$(./build/bin/nvim --version | head -1 | awk '{print $2}' | sed "s/v//g")
porg -lp neovim-$NEOVIM_VERSION "make CMAKE_INSTALL_PREFIX=$HOME/.local/usr install"

# Check package
porg neovim
cd $HOME

