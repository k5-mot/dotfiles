#!/usr/bin/env bash

## Lua

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r lua
fi

rm -rf $HOME/.local/src/lua
mkdir -p $HOME/.local/src/lua
cd $HOME/.local/src/lua

wget http://www.lua.org/ftp/lua-5.4.3.tar.gz
tar -zxvf lua-*.tar.gz
cd lua-*/

#./configure --prefix=$HOME/.local/usr
make INSTALL_TOP=$HOME/.local/usr
porg -lD make install INSTALL_TOP=$HOME/.local/usr
porg lua
cd $HOME
