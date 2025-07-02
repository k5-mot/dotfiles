#!/usr/bin/env zsh

printf "\e[30;42;1m701_setup-zinit.shE\e[0m\n"

source "${XDG_CONFIG_HOME}/zsh/.zshenv"
source "${XDG_CONFIG_HOME}/zsh/.zshrc"

zinit self-update
zinit update --all
zinit delete --clean
zinit cclear
