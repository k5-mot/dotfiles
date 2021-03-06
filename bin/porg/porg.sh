#!/usr/bin/env bash

## porg
cd $HOME
mkdir -p $HOME/.local
mkdir -p $HOME/.local/src
cd $HOME/.local/src
rm -rf $HOME/.local/src/porg
mkdir -p $HOME/.local/src/porg
cd $HOME/.local/src/porg/
wget --content-disposition https://sourceforge.net/projects/porg/files/latest/download
tar -xzvf porg-*.tar.gz
cd porg-*/
mkdir -p $HOME/.local/usr
mkdir -p $HOME/.local/usr/bin
mkdir -p $HOME/.local/usr/lib
mkdir -p $HOME/.local/etc
mkdir -p $HOME/.local/var
mkdir -p $HOME/.local/var/log
mkdir -p $HOME/.local/var/log/porg
./configure --prefix=$HOME/.local/usr \
  --sysconfdir=$HOME/.local/etc \
  --with-porg-logdir=$HOME/.local/var/log/porg \
  --disable-grop
make
./porg/porg -lD make install
porg porg
cd $HOME
