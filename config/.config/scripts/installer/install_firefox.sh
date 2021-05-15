#!/usr/bin/env zsh

## Install firefox

## Create destination of download.
cd $HOME
mkdir -p $HOME/.local
mkdir -p $HOME/.local/src
mkdir -p $HOME/.local/src/firefox
cd $HOME/.local/src/firefox

## Download firefox
# NOTE: http://ftp.mozilla.org/pub/firefox/releases/latest/README.txt
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
rm -rf firefox/
tar -jxvf firefox.tar.bz2

## Install firefox.
mkdir -p $HOME/.local/opt
rm -rf $HOME/.local/opt/firefox
mv $HOME/.local/src/firefox/firefox $HOME/.local/opt
cd $HOME

