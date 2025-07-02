#!/usr/bin/env zsh

# mise
curl https://mise.run | sh
~/.local/bin/mise --version
export PATH="$HOME/.local/bin:$PATH"

mise --version
eval "$(~/.local/bin/mise activate zsh)"
# mise reshim
# mise doctor
mise install -y
mise reshim
