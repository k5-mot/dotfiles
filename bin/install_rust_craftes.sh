#!/usr/bin/env bash

## Alacritty
mkdir -pv $HOME/.local
mkdir -pv $HOME/.local/src
cd $HOME/.local/src
rm -rf $HOME/.local/src/alacritty

git clone https://github.com/alacritty/alacritty.git
cd alacritty
rustup override set stable
rustup update stable
cargo build --release
infocmp alacritty

cd $HOME
