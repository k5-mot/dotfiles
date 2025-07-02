#!/usr/bin/env bash

printf "\e[30;42;1m603_install-via-cargo.shE\e[0m\n"

rustup update
rustup default stable
cargo --version
cargo install \
    exa bat fd-find hexyl procs ripgrep sd \
    zoxide svls texlab stylua git-delta \
    sheldon alacritty starship zellij
cargo install --list
