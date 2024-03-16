#!/bin/sh

rustup update
rustup default stable
cargo --version
cargo install \
    exa bat fd-find hexyl procs ripgrep sd \
    zoxide svls texlab stylua git-delta \
    sheldon alacritty starship zellij
cargo install --list
