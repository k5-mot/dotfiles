#!/usr/bin/env bash

## vim

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r vim
fi
rm -rf $HOME/.local/src/vim
git clone https://github.com/vim/vim.git
cd $HOME/.local/src/vim

LDFLAGS="-Wl,-rpath=$HOME/.local/usr/lib" ./configure \
  --enable-cscope \
  --enable-terminal \
  --enable-fontset \
  --enable-multibyte \
  --enable-nls \
  --enable-fail-if-missing \
  --enable-python3interp \
  --enable-pythoninterp \
  --enable-rubyinterp \
  --enable-luainterp \
  --with-features=huge \
  --enable-xim \
  --enable-gpm \
  --with-x \
  --enable-gui=auto \
  --with-python3-command=$HOME/.local/usr/bin/python3 \
  --with-python-command=$HOME/.local/usr/bin/python2 \
  --with-ruby-command=$HOME/.local/usr/bin/ruby \
  --with-lua-prefix=$HOME/.local/usr \
  --prefix=$HOME/.local/usr
  #--enable-gui=yes \
  #--enable-xim \
  #--with-x \
  #--enable-gpm \
make
export VIM_VERSION=$(./src/vim --version | head -1 | awk '{print $5}')

porg -lp vim-$VIM_VERSION make install
porg vim
cd $HOME

