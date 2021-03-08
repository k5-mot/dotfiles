#!/usr/bin/env bash

## qhull

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r qhull
fi
rm -rf $HOME/.local/src/qhull
git clone https://github.com/qhull/qhull.git
cd qhull/
make
export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH
make test
porg -lD make install PREFIX=$HOME/.local/usr
porg qhull
cd $HOME
