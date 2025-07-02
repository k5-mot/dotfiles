#!/usr/bin/env bash

# mise
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

mise --version
eval "$(~/.local/bin/mise activate zsh)"
mise reshim
mise doctor
mise install -y
mise reshim
