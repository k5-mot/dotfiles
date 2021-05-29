#!/usr/bin/env bash

## GMP

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r gmp
fi

rm -rf $HOME/.local/src/gmp
mkdir $HOME/.local/src/gmp
cd $HOME/.local/src/gmp

wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.bz2
wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.bz2.sig

tar -xvf gmp-*.tar.bz2
cd gmp-*/

./configure \
  --prefix=$HOME/.local/usr \
  --enable-cxx

make
make check
porg -lD make install
porg gmp

cd $HOME
