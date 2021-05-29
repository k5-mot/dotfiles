#!/usr/bin/env bash

## MPC

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r mpc
fi

rm -rf $HOME/.local/src/mpc
mkdir $HOME/.local/src/mpc
cd $HOME/.local/src/mpc

wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz.sig

tar -xvf mpc-*.tar.gz
cd mpc-*/

./configure \
  --prefix=$HOME/.local/usr \
  --with-gmp=$HOME/.local/usr \
  --with-mpfr=$HOME/.local/usr

make -s -j4
make check -s -j4
porg -lD make install
porg mpc

cd $HOME
