#!/usr/bin/env bash

## Node.js

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r node
fi

rm -rf $HOME/.local/src/node
mkdir -p $HOME/.local/src/node
cd $HOME/.local/src/node

NODEJS_VERSION=14.17.0
#NODEJS_VERSION=12.22.1
#wget https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz
wget https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz
tar -zxvf node-*.tar.gz
cd node-*/



#CPP_HEADER="$(ls -1 ~/.local/usr/include/c++ | tail -1 | sed 's/[@\/]//')"
#unset LIBRARY_PATH INCLUDE CPATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH PKG_CONFIG_PATH
#
#export PYTHON=$HOME/.local/usr/bin/python3
#$PYTHON \
#./configure \
#  --prefix=$HOME/.local/usr

#INCLUDE=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#CPATH=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#C_INCLUDE_PATH=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#CPLUS_INCLUDE_PATH=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#LD_LIBRARY_PATH=$HOME/.local/usr/lib \
#make
#INCLUDE=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#CPATH=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#C_INCLUDE_PATH=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#CPLUS_INCLUDE_PATH=$HOME/.local/usr/include:$HOME/.local/usr/include/c++/${CPP_HEADER} \
#LD_LIBRARY_PATH=$HOME/.local/usr/lib \
porg -lp  node-${NODEJS_VERSION} "cp -rf bin/     $HOME/.local/usr"
porg -lp+ node-${NODEJS_VERSION} "cp -rf include/ $HOME/.local/usr"
porg -lp+ node-${NODEJS_VERSION} "cp -rf lib/     $HOME/.local/usr"
porg -lp+ node-${NODEJS_VERSION} "cp -rf share/   $HOME/.local/usr"
porg node

npm install --global npm
npm install --global yarn
npm install --global neovim
npm list    --global

cd $HOME

