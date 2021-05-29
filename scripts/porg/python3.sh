#!/usr/bin/env bash

## python3

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r python-3
fi

rm -rf $HOME/.local/src/python3
mkdir -p $HOME/.local/src/python3
cd $HOME/.local/src/python3

wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz 
tar -zxvf Python-*.tgz
cd Python-*/

./configure --prefix=$HOME/.local/usr
make
porg -lD make install
porg Python-3* 
cd $HOME
