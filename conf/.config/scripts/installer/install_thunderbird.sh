#!/usr/bin/env zsh

## Install Thunderbird

## Create destination of download.
cd $HOME
mkdir -p $HOME/.local
mkdir -p $HOME/.local/src
mkdir -p $HOME/.local/src/thunderbird
cd $HOME/.local/src/thunderbird

## Download Thunderbird
# NOTE: http://ftp.mozilla.org/pub/thunderbird/releases/latest/README.txt
wget -O thunderbird.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=en-US"
rm -rf thunderbird/
tar -jxvf thunderbird.tar.bz2

## Install Thunderbird.
mkdir -p $HOME/.local/opt
rm -rf $HOME/.local/opt/thunderbird
mv $HOME/.local/src/thunderbird/thunderbird $HOME/.local/opt
cd $HOME

