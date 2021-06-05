#!/usr/bin/env bash

## Install firefox
set -x

## Create destination of download.
cd $HOME
if (type "porg" > /dev/null 2>&1); then
  porg -r texlive
fi

rm -rf ~/.texlive*
rm -rf ~/.texmf
rm -rf ~/.cache/texlive*
rm -rf ~/.cache/texmf

rm -rf   $HOME/.local/src/texlive
mkdir -p $HOME/.local/src/texlive
cd $HOME/.local/src/texlive

## Download Installer
wget http://ftp.kddilabs.jp/pub/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz
wget http://ftp.kddilabs.jp/pub/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz.sha256
tar -zxvf install-tl-unx.tar.gz
cd install-tl-*/

## Install
rm -rf $HOME/.local/opt/texlive
mkdir -p $HOME/.local/opt
cp -rf ~/dotfiles/scripts/installer/texlive.profile .
porg -lp texlive "./install-tl --profile=texlive.profile"
porg texlive
cd $HOME

#sudo mkdir -p /usr/local/texlive
#sudo chown -R $(whoami):$(whoami) /usr/local/
#sudo bash ./install-tl


