#!/usr/bin/env bash

## ncurses

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r ncurses
fi
rm -rf $HOME/.local/src/ncurses
mkdir -p ncurses
cd $HOME/.local/src/ncurses
wget ftp://ftp.invisible-island.net/ncurses/ncurses.tar.gz
tar -zxvf ncurses.tar.gz
cd ncurses-*
./configure \
  --enable-pc-files \
  --prefix=$HOME/.local/usr \
  --with-pkg-config-libdir=$HOME/.local/usr/lib/pkgconfig \
  --with-termlib \
  --with-shared
make
porg -lD make install
porg ncurses
cd $HOME
