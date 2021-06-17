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

# Install package
git checkout stable
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/usr"
export NEOVIM_VERSION=$(./build/bin/nvim --version | head -1 | awk '{print $2}' | sed "s/v//g")
porg -lp neovim-$NEOVIM_VERSION "make CMAKE_INSTALL_PREFIX=$HOME/.local/usr install"

# Check package
porg neovim
cd $HOME

