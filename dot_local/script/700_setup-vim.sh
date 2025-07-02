#!/usr/bin/env bash

printf "\e[30;42;1m700_setup-vim.shE\e[0m\n"

echo "Vim Setup"
vim +PlugUpdate +PlugUpgrade +qall

echo "Neovim Setup"
nvim +PackerUpdate +qall
