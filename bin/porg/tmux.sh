#!/usr/bin/env bash

## tmux

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r tmux
fi

rm -rf $HOME/.local/src/tmux
mkdir -p tmux
cd $HOME/.local/src/tmux

export TMUX_URL=$(curl -s https://api.github.com/repos/tmux/tmux/releases/latest | grep "\"browser_download_url\": \"[^\"]*.tar.gz\"" | sed "s/\"browser_download_url\": //g" | sed "s/[\" ]//g")
wget $TMUX_URL
tar -zxvf tmux-*.tar.gz
mv tmux-*.tar.gz tmux.tar.gz
cd tmux-*

#git clone https://github.com/tmux/tmux.git
#cd $HOME/.local/src/tmux
#git checkout $(git tag | sort -V | tail -n 1)
#sh autogen.sh

PKG_CONFIG_PATH=$HOME/.local/usr/lib/pkgconfig ./configure \
  --prefix=$HOME/.local/usr
#  --enable-static \
#  LDFLAGS="-L$HOME/.local/usr/lib" \
#  CFLAGS="-I$HOME/.local/usr/include"
make -j4
porg -lD make install
porg tmux
cd $HOME
