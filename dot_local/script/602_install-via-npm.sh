#!/usr/bin/env bash

printf "\e[30;42;1m602_install-via-npm.shE\e[0m\n"

npm update  --global
npm install --global --force npm
npm --version
npm install --global yarn neovim gtop
npm list    --global
