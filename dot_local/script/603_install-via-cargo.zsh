#!/usr/bin/env bash

rustup update
rustup default stable
cargo --version
cargo install \
    exa bat fd-find hexyl procs ripgrep sd zoxide \
    starship
    # sheldon alacritty starship zellij \
    # svls texlab stylua git-delta


cargo install --list
