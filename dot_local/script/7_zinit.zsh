#!/usr/bin/env zsh

source "${HOME}/.zshenv"
source "${XDG_CONFIG_HOME}/zsh/zshenv"
source "${XDG_CONFIG_HOME}/zsh/zshrc"

zinit self-update
zinit update --all
zinit delete --clean
zinit cclear
