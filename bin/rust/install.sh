#!/usr/bin/env bash

## Rust
cd $HOME

rm -rf $HOME/.cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

