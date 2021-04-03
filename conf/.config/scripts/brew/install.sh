#!/bin/bash

## Optional
#export HOMEBREW_NO_ENV_FILTERING=1
#export HOMEBREW_DEVELOPER=1
#export HOMEBREW_CURL_PATH=$HOME/.local/bin/curl
#export HOMEBREW_GIT_PATH=$HOME/.local/bin/git

## Uninstall
rm -rf $HOME/.linuxbrew

## Download
git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew

## Install
mkdir ~/.linuxbrew/bin
ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)

## Check
$HOME/.linuxbrew/bin/brew doctor

