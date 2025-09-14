#!/bin/sh

python3 -m pip install --upgrade pip
python3 -m pip --version
python3 -m pip install \
    flake8 autopep8 \
    jupyter neovim  \
    matplotlib \
    numpy scipy \
    pandas
    # torch torchvision tensorflow
python3 -m pip list


gem update
gem --version
gem install neovim
gem list


npm update  --global
npm install --global npm
npm --version
npm install --global --force yarn
npm install --global yarn eslint neovim gtop \
    prettier @fsouza/prettierd
npm list    --global


rustup update
rustup default stable
cargo --version
cargo install \
    exa bat fd-find hexyl procs ripgrep sd \
    zoxide svls texlab stylua git-delta \
    sheldon alacritty starship zellij
cargo install --list
