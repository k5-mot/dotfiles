<<<<<<< Updated upstream:dot_local/script/700_setup-vim.sh
#!/usr/bin/env bash

echo "Vim Setup"
vim +PlugUpdate +PlugUpgrade +qall

echo "Neovim Setup"
nvim +PackerUpdate +qall
=======
#!/bin/sh

echo "Vim Setup"
vim +PlugUpdate +PlugUpgrade +qall

echo "Neovim Setup"
nvim +PackerUpdate +qall
>>>>>>> Stashed changes:dot_local/script/7_vim.sh
