#!/usr/bin/env bash

## ISL

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r isl
fi

rm -rf $HOME/.local/src/isl
mkdir $HOME/.local/src/isl
cd $HOME/.local/src/isl

wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2

tar -xvf isl-*.tar.bz2

cd isl-*/

./configure \
  --prefix=$HOME/.local/usr \
  --with-gmp-prefix=$HOME/.local/usr

make -j4
make check
porg -lD make install
porg isl

cd $HOME
