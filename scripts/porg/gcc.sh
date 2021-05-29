#!/usr/bin/env bash

## GCC

set -x

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r gcc
fi

rm -rf $HOME/.local/src/gcc
mkdir $HOME/.local/src/gcc
cd $HOME/.local/src/gcc

GCC_VERSION=8.5.0
wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz
wget https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz.sig
tar -xzvf gcc-*.tar.gz
cd gcc-*/

./contrib/download_prerequisites

mkdir build
cd build

../configure \
  --enable-languages=c,c++ \
  --prefix=$HOME/.local/usr \
  --disable-bootstrap \
  --disable-multilib 
  --with-gmp=$HOME/.local/usr \
  --with-mpc=$HOME/.local/usr \
  --with-mpfr=$HOME/.local/usr \
  --with-isl=$HOME/.local/usr

unset LIBRARY_PATH INCLUDE CPATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH PKG_CONFIG_PATH 

INCLUDE=$HOME/.local/usr/include \
CPATH=$HOME/.local/usr/include \
C_INCLUDE_PATH=$HOME/.local/usr/include \
CPLUS_INCLUDE_PATH=$HOME/.local/usr/include \
LD_LIBRARY_PATH=$HOME/.local/usr/lib \
make 

porg -lp gcc-${GCC_VERSION} make install

porg gcc
cd $HOME
