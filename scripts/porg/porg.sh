#!/usr/bin/env bash

## porg

# Setup dir
mkdir -pv $HOME/.local/usr
mkdir -pv $HOME/.local/src
mkdir -pv $HOME/.local/usr/bin
mkdir -pv $HOME/.local/usr/lib
mkdir -pv $HOME/.local/etc
mkdir -pv $HOME/.local/var
mkdir -pv $HOME/.local/var/log
mkdir -pv $HOME/.local/var/log/porg

# Change dir.
cd $HOME
cd $HOME/.local/src

# Remove package.
if (type "porg" > /dev/null 2>&1); then
  porg -r porg
fi
rm -rf   $HOME/.local/src/porg
mkdir -p $HOME/.local/src/porg
cd       $HOME/.local/src/porg

## Download
wget --content-disposition https://sourceforge.net/projects/porg/files/latest/download
tar -xzvf porg-*.tar.gz
cd porg-*/

# Install package.
./configure \
  --prefix=$HOME/.local/usr \
  --sysconfdir=$HOME/.local/etc \
  --with-porg-logdir=$HOME/.local/var/log/porg \
  --disable-grop
make
./porg/porg -lD "make install"

# Check package.
./porg/porg porg
cd $HOME

