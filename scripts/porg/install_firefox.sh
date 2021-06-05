#!/usr/bin/env bash

## Install firefox
set -x

## Create destination of download.
cd $HOME
if (type "porg" > /dev/null 2>&1); then
  porg -r firefox
fi

rm -rf   $HOME/.local/src/firefox
mkdir -p $HOME/.local/src/firefox
cd $HOME/.local/src/firefox

## Download firefox
# NOTE: http://ftp.mozilla.org/pub/firefox/releases/latest/README.txt
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
tar -xvf firefox.tar.bz2

## Install firefox.
rm -rf $HOME/.local/opt/firefox
mkdir -p $HOME/.local/opt
export FIREFOX_VERSION=$($HOME/.local/src/firefox/firefox/firefox --version | awk '{print $3}')
porg -lp firefox-${FIREFOX_VERSION} "cp -rf $HOME/.local/src/firefox/firefox $HOME/.local/opt"
porg firefox
cd $HOME

