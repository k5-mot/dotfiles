#!/usr/bin/env bash

## MPFR

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r mpfr
fi

rm -rf $HOME/.local/src/mpfr
mkdir $HOME/.local/src/mpfr
cd $HOME/.local/src/mpfr

wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz
wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz.sig

tar -xvf mpfr-*.tar.gz

cd mpfr-*/

./configure \
  --prefix=$HOME/.local/usr \
  --with-gmp=$HOME/.local/usr

make -s -j4
make -s check
porg -lD make install
porg mpfr

cd $HOME
