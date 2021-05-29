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

NODEJS_VERSION=16.2.0
wget https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz
tar -zxvf node-*.tar.gz
cd node-*/

export PYTHON=$HOME/.local/usr/bin/python3
$PYTHON ./configure \
  --prefix=$HOME/.local/usr
make
porg -lp node-${NODEJS_VERSION} make install
porg node
cd $HOME

