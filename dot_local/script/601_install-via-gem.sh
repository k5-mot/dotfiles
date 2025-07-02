#!/usr/bin/env bash

printf "\e[30;42;1m601_install-via-gem.shE\e[0m\n"

gem update
gem --version
gem install neovim
gem list
