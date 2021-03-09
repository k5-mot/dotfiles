#!/usr/bin/env bash

## xsel

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r xsel
fi

rm -rf $HOME/.local/src/xsel
mkdir -p xsel
cd $HOME/.local/src/xsel

curl -OL http://www.vergenet.net/~conrad/software/xsel/download/xsel-1.2.0.tar.gz
mv xsel-*.tar.gz xsel.tar.gz
tar -xzvf xsel.tar.gz
cd xsel-*
#./autogen.sh
./configure --prefix=$HOME/.local/usr
make
#make check
porg -lD make install
porg xsel
cd $HOME
