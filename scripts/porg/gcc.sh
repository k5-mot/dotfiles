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

#wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-10.2.0/gcc-10.2.0.tar.gz
wget https://gcc.gnu.org/ftp/gcc/releases/gcc-10.3.0/gcc-10.3.0.tar.gz
tar -xzvf gcc-*.tar.gz
cd gcc-*/

mkdir build
cd build

../configure \
  --enable-languages=all \
  --prefix=$HOME/.local/usr \
  --disable-bootstrap \
  --disable-multilib 
  #--with-gmp=$HOME/.local/usr \
  #--with-mpc=$HOME/.local/usr \
  #--with-mpfr=$HOME/.local/usr \
  #--with-isl=$HOME/.local/usr

#unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
#LD_LIBRARY_PATH=$HOME/.local/usr/lib
make 
GCC_VERSION=$(./gcc --version)
porg -lp gcc-$GCC_VERSION make install

porg gcc
cd $HOME
