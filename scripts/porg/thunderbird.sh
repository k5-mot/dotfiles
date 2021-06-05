#!/usr/bin/env bash

## Install Thunderbird
set -x

## Create destination of download.
cd $HOME
if (type "porg" > /dev/null 2>&1); then
  porg -r thunderbird
fi

rm -rf $HOME/.local/src/thunderbird
mkdir -p $HOME/.local/src/thunderbird
cd $HOME/.local/src/thunderbird

## Download Thunderbird
# NOTE: http://ftp.mozilla.org/pub/thunderbird/releases/latest/README.txt
wget -O thunderbird.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=en-US"
tar -xvf thunderbird.tar.bz2

## Install Thunderbird.
rm -rf $HOME/.local/opt/thunderbird
mkdir -p $HOME/.local/opt
export THUNDERBIRD_VERSION=$($HOME/.local/src/thunderbird/thunderbird/thunderbird --version | awk '{print $2}')
porg -lp thunderbird-${THUNDERBIRD_VERSION} "cp -rf $HOME/.local/src/thunderbird/thunderbird $HOME/.local/opt"
porg thunderbird
cd $HOME

