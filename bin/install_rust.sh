#!/usr/bin/env bash

## Rust
cd $HOME

rm -rf $HOME/.cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

## Cargo craftes.
cargo install exa
cargo install bat
cargo install hexyl
#cargo install fd
cargo install procs
cargo install ripgrep

