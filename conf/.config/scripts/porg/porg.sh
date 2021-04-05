#!/usr/bin/env bash

##
## porg
##

# Create source directory.
cd $HOME
mkdir -pv $HOME/.local
mkdir -pv $HOME/.local/src
cd $HOME/.local/src

# Remove source directory.
rm -rf $HOME/.local/src/porg

# Download source.
mkdir -pv $HOME/.local/src/porg
cd $HOME/.local/src/porg/
wget --content-disposition https://sourceforge.net/projects/porg/files/latest/download
tar -xzvf porg-*.tar.gz
cd porg-*/

# Create local bin, lib and more...
mkdir -pv $HOME/.local/usr
mkdir -pv $HOME/.local/usr/bin
mkdir -pv $HOME/.local/usr/lib
mkdir -pv $HOME/.local/etc
mkdir -pv $HOME/.local/var
mkdir -pv $HOME/.local/var/log
mkdir -pv $HOME/.local/var/log/porg

# Install
./configure --prefix=$HOME/.local/usr \
  --sysconfdir=$HOME/.local/etc \
  --with-porg-logdir=$HOME/.local/var/log/porg \
  --disable-grop
make
./porg/porg -lD make install

./porg/porg porg
cd $HOME

