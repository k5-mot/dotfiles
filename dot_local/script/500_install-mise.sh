#!/usr/bin/env bash

printf "\e[30;42;1m500_install-mise.shE\e[0m\n"

# mise
curl https://mise.run | sh
~/.local/bin/mise --version
# eval "$(~/.local/bin/mise activate zsh)"
mise reshim
mise doctor
mise install -y
mise reshim
