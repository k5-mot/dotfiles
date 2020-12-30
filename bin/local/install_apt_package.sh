#!bin/sh

## Change package server to mirror servers
sudo sed -i.bak -r 's!(deb|deb-src) \S+!\1 mirror://mirrors.ubuntu.com/mirrors.txt!' /etc/apt/

## Install packages
sudo apt install -y vim
sudo apt install -y emacs
sudo apt install -y neovim
sudo apt install -y curl
sudo apt install -y llvm
sudo apt install -y sqlite3
sudo apt install -y libssl-dev
sudo apt install -y libbz2-dev
sudo apt install -y libreadline-dev
sudo apt install -y libsqlite3-dev
sudo apt install -y libncurses5-dev
sudo apt install -y libncursesw5-dev
sudo apt install -y python-tk
sudo apt install -y python3-tk
sudo apt install -y tk-dev
sudo apt install -y aria2
sudo apt install -y ccache

