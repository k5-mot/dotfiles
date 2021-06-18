#!/usr/bin/env bash

## Make

# Change dir.
cd $HOME
cd $HOME/.local/src

# Remove package.
if (type "porg" > /dev/null 2>&1); then
  porg -r make
fi
rm -rf $HOME/.local/src/make

# Download package.
wget http://ftp.gnu.org/gnu/make/make-4.3.tar.gz
wget http://ftp.gnu.org/gnu/make/make-4.3.tar.gz.sig
tar -zxvf make-*.tar.gz
cd make-*/

# Install package.
./configure \
  --prefix=$HOME/.local/usr
make
porg -lD "make install"

# Check package.
porg make

