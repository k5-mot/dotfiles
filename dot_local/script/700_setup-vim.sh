#!/usr/bin/env bash

echo "Vim Setup"
vim +PlugUpdate +PlugUpgrade +qall

echo "Neovim Setup"
nvim +PackerUpdate +qall
