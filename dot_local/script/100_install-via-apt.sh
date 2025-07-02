#!/usr/bin/env bash

if ! command -v apt > /dev/null 2>&1; then
    exit 0
fi

### Update
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install -y ca-certificates curl gnupg
sudo apt install -y --no-install-recommends unzip git wget
sudo apt install -y --no-install-recommends vim tmux zsh

### Requirements

# Python
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install -y --no-install-recommends \
    build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Ruby
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
# sudo apt install -y --no-install-recommends \
#     autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

# Node.js
# https://github.com/nodejs/node/blob/main/BUILDING.md#building-nodejs-on-supported-platforms
sudo apt install -y --no-install-recommends \
    python3 g++ make python3-pip

# Lua
# https://www.lua.org/manual/5.4/readme.html
sudo apt install -y --no-install-recommends \
    make

# Vim
# https://github.com/vim/vim/blob/master/src/INSTALL
sudo apt install -y --no-install-recommends \
    git make clang libtool-bin libxt-dev libpython3-dev xclip
#    libgtk-3-dev valgrind

# Neovim
# https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
sudo apt install -y --no-install-recommends \
    ninja-build gettext cmake unzip curl

# tmux
# https://github.com/tmux/tmux/wiki/Installing#building-dependencies
sudo apt install -y --no-install-recommends \
    libevent-dev ncurses-dev build-essential bison pkg-config \
    libutf8proc-dev libutempter0
