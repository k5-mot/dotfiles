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

wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz
tar -zxvf Python-*.tgz
cd Python-*/

./configure \
  --prefix=$HOME/.local/usr \
  --enable-optimizations \
  --with-openssl=$HOME/.local/usr \
  --with-ensurepip \
  --enable-shared \
  --with-lto
make
porg -lD make install
porg Python-3*

curl -kL https://bootstrap.pypa.io/get-pip.py | python3
python3 -m pip install --upgrade pip
python3 -m pip install pip-review
python3 -m pip install flake8
python3 -m pip install autopep8
python3 -m pip install jupyter
python3 -m pip install neovim
python3 -m pip install matplotlib
python3 -m pip install numpy
python3 -m pip install scipy
python3 -m pip install compiledb
python3 -m pip install openpyxl
python3 -m pip install turtle
python3 -m pip install pandas
python3 -m pip install torch
python3 -m pip install torchvision
python3 -m pip install tensorflow
python3 -m pip install powerline-status
python3 -m pip-review --auto
python3 -m pip -V
python3 -m pip list

cd $HOME
