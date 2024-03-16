#!/usr/bin/env zsh

source ~/.zshrc
zinit self-update
zinit update --all
zinit delete --clean
zinit cclear
