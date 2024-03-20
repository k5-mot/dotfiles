#!/bin/sh

Write-Output "Vim Setup"
vim +PlugUpdate +PlugUpgrade +qall

Write-Output "Neovim Setup"
nvim +PackerUpdate +qall
