#!/usr/bin/env bash

## neomutt
cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r neomutt
fi
rm -rf $HOME/.local/src/neomutt
git clone --verbose --progress https://github.com/neomutt/neomutt.git
cd $HOME/.local/src/neomutt

./configure --prefix=$HOME/.local/usr \
  --with-ncurses=$HOME/.local/usr \
  --disable-idn \
  --idn2 \
  --with-idn2=$HOME/.local/usr
make
porg -lD make install
porg neomutt
cd $HOME

