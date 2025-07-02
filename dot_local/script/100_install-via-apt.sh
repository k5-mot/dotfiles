#!/usr/bin/env bash

if ! command -v apt > /dev/null 2>&1; then
    exit 0
fi

### Update
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install -y ca-certificates curl gnupg curl unzip zsh
sudo chsh -s /bin/zsh

### Requirements

#  git cmake pkg-config curl wget xclip zsh cmake unzip curl

# # Python
# # https://github.com/pyenv/pyenv/wiki#suggested-build-environment
# sudo apt install -y \
#     build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# # Ruby
# # https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
# sudo apt install -y \
#     autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

# # Node.js
# # https://github.com/nodejs/node/blob/main/BUILDING.md#building-nodejs-on-supported-platforms
# sudo apt install -y \
#     python3 g++ make python3-pip

# # Lua
# # https://www.lua.org/manual/5.4/readme.html
# sudo apt install -y \
#     make

# # Vim
# # https://github.com/vim/vim/blob/master/src/INSTALL
# sudo apt install -y \
#     git make clang libtool-bin libxt-dev libgtk-3-dev libpython3-dev valgrind

# # Neovim
# # https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
# sudo apt install -y \
#     ninja-build gettext cmake unzip curl

# # tmux
# # https://github.com/tmux/tmux/wiki/Installing#building-dependencies
# sudo apt install -y \
#     libevent-dev ncurses-dev build-essential bison pkg-config \
#     libutf8proc-dev libutempter0

# Tools
# sudo apt install --install-suggests -y vim neovim zsh tmux
