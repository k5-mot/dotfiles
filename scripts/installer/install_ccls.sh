#!/usr/bin/env bash

## Install CCLS

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r ccls
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/ccls
cd $HOME/.local/src/

## Download
git clone --depth=1 https://github.com/MaskRay/ccls.git
cd $HOME/.local/src/ccls/

## Install
export CCLS_VERSION=$(git tag | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*' | tail -1)
cmake -H. \
  -BRelease \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=/path/to/clang+llvm-xxx \
  -DCMAKE_INSTALL_PREFIX=$HOME/.local/usr
porg -lp ccls-${CCLS_VERSION} "cmake --build Release"

## Check
porg ccls
cd $HOME
