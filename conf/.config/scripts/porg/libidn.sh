#!/usr/bin/env bash

## libidn
cd $HOME
cd $HOME/.local/src

if (type "porg" > /dev/null 2>&1); then
  porg -r libidn
fi
rm -rf $HOME/.local/src/libidn
mkdir -p $HOME/.local/src/libidn
cd $HOME/.local/src/libidn
export LIBIDN_URL="http://ftp.iij.ad.jp/pub/gnu/libidn/libidn-1.36.tar.gz"
wget $LIBIDN_URL
tar -zxvf libidn-*.tar.gz
cd libidn-*
./configure --prefix=$HOME/.local/usr
make
porg -lD make install
porg libidn
cd $HOME

