#!/usr/bin/env bash

## VSCode

# Change dir.
cd $HOME
cd $HOME/.local/src

# Remove package.
if (type "porg" > /dev/null 2>&1); then
  porg -r vscode
fi
rm -rf   $HOME/.local/src/vscode
mkdir -p $HOME/.local/src/vscode
cd       $HOME/.local/src/vscode

## Download firefox
# NOTE: https://code.visualstudio.com/updates/v1_52
wget --trust-server-names "https://update.code.visualstudio.com/1.52.1/linux-x64/stable"
tar -xvf code-*.tar.gz

# Install package.
rm -rf $HOME/.local/opt/VSCode-linux-x64
mkdir -p $HOME/.local/opt
export VSCODE_VERSION=$($HOME/.local/src/vscode/VSCode-linux-x64/bin/code --version | head -1 | awk '{print $1}')
porg -lp vscode-${VSCODE_VERSION} "cp -rf $HOME/.local/src/vscode/VSCode-linux-x64 $HOME/.local/opt"

# Check package.
porg vscode
cd $HOME

