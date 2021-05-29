#!/usr/bin/env bash

## python2

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r python-2
fi

rm -rf $HOME/.local/src/python2
mkdir -p $HOME/.local/src/python2
cd $HOME/.local/src/python2

wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz 
tar -zxvf Python-*.tgz
cd Python-*/

./configure --prefix=$HOME/.local/usr
make
porg -lD make install
porg Python-2* 

curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2
python3 -m pip -V

cd $HOME
