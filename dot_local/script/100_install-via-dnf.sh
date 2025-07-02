#!/usr/bin/env bash

if ! command -v dnf > /dev/null 2>&1; then
    exit 0
fi


### Update
sudo dnf makecache --refresh
sudo dnf updateinfo
sudo dnf upgrade -y
sudo dnf autoremove -y

### Group Install
sudo dnf groupinstall -y "Minimal Install"
sudo dnf groupinstall -y "Standard"
sudo dnf groupinstall -y "Development Tools" --setopt=group_package_types=mandatory,default,optional
sudo dnf groupinstall -y "Japanese Support"

### Install
sudo dnf install -y fonts-japanese
sudo dnf install -y epel-release
sudo dnf install -y gcc-gfortran libgfortran
sudo dnf install -y perl-devel
sudo dnf install -y zsh


### Requirements

# Python
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo dnf install -y \
    make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2

# Ruby
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
sudo dnf install -y \
    autoconf gcc rust patch make bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel

# Node.js
# https://github.com/nodejs/node/blob/main/BUILDING.md#building-nodejs-on-supported-platforms
sudo dnf install -y \
    python3 gcc-c++ make python3-pip

# Lua
# https://www.lua.org/manual/5.4/readme.html
sudo dnf install -y make

# Neovim
# https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
sudo dnf install -y \
    ninja-build cmake gcc make unzip gettext curl glibc-gconv-extra

# Tools
sudo dnf install -y vim-enhanced tmux
