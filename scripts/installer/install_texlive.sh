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
mkdir -pv $HOME/.local/src/texlive
mkdir -pv $HOME/.local/src/texlive/2021
cd $HOME/.local/src/texlive/2021

## Change profile
cp -rf ~/dotfiles/scripts/installer/texlive.profile .
cp -rf texlive.profile profile_buf1.txt
cp -rf texlive.profile profile_buf2.txt
sed -e "4a TEXMFSYSVAR $HOME/.local/opt/texlive/2021/texmf-var" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFSYSCONFIG $HOME/.local/opt/texlive/2021/texmf-config" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFLOCAL $HOME/.local/opt/texlive/texmf-local" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFHOME $HOME/.cache/texlive2021/texmf" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFVAR $HOME/.cache/texlive2021/texmf-var" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXMFCONFIG $HOME/.cache/texlive2021/texmf-config" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt profile_buf2.txt
sed -e "4a TEXDIR $HOME/.local/opt/texlive/2021" profile_buf2.txt > profile_buf1.txt
cp -rf profile_buf1.txt texlive.profile

## Download Installer
wget http://ftp.kddilabs.jp/pub/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz
wget http://ftp.kddilabs.jp/pub/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz.sha256
tar -zxvf install-tl-unx.tar.gz
cd install-tl-*/

## Install
rm -rf $HOME/.local/opt/texlive
mkdir -pv $HOME/.local/opt
mkdir -pv $HOME/.local/opt/texlive
mkdir -pv $HOME/.local/opt/texlive/2021

porg -lp texlive-2021 "./install-tl --profile=../texlive.profile"
porg texlive
cd $HOME

