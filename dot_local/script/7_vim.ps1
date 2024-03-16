#!/bin/sh

Write-Output "Vim Setup"
vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

Write-Output "Neovim Setup"
nvim +PackerUpdate +qall
