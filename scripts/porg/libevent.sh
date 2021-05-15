#!/usr/bin/env bash

## libevent

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r libevent
fi
rm -rf $HOME/.local/src/libevent
mkdir -p libevent
cd $HOME/.local/src/libevent
export LIBEVENT_URL=$(curl -s https://api.github.com/repos/libevent/libevent/releases/latest | grep "\"browser_download_url\": \"[^\"]*.tar.gz\"" | sed "s/\"browser_download_url\": //g" | sed "s/[\" ]//g")
wget $LIBEVENT_URL
tar -zxvf libevent-*-stable.tar.gz
cd libevent-*-stable
./configure --prefix=$HOME/.local/usr \
  --with-shared
make
porg -lD make install
porg libevent
cd $HOME
