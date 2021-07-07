#!/usr/bin/env bash

## openssl

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r openssl
fi

rm -rf $HOME/.local/src/openssl
mkdir -pv $HOME/.local/src/openssl
cd $HOME/.local/src/openssl

wget https://www.openssl.org/source/openssl-1.1.1.tar.gz
tar -zxvf openssl-*.tar.gz
cd openssl-*/

./config \
  --prefix=$HOME/.local/usr \
  --openssldir=$HOME/.local/usr \
  shared zlib
#make depend
make
#make test
porg -lD make install
porg openssl

cd $HOME
