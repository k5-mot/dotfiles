#!/usr/bin/env bash

printf "\e[30;42;1m600_install-via-pip.shE\e[0m\n"

python3 -m pip install --upgrade pip
python3 -m pip --version
python3 -m pip install jupyter neovim pre-commit
python3 -m pip list
