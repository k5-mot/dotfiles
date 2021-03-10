#!/usr/bin/env bash

## Git

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r git
fi
rm -rf $HOME/.local/src/git
git clone https://github.com/git/git.git
cd $HOME/.local/src/git
make prefix=$HOME/.local/usr
export GIT_VERSION=$(./git --version | head -1 | awk '{print $3}')
porg -lp git-$GIT_VERSION make prefix=$HOME/.local/usr install
porg git
cd $HOME
