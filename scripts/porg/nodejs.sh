#!/usr/bin/env bash

## Node.js

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r nodejs
fi

rm -rf $HOME/.local/src/nodejs
mkdir -p $HOME/.local/src/nodejs
cd $HOME/.local/src/nodejs

wget https://nodejs.org/dist/v16.2.0/node-v16.2.0.tar.gz
tar -zxvf node-*.tar.gz
cd node-*/

./configure --prefix=$HOME/.local/usr
make
porg -lD make install
porg node
cd $HOME
