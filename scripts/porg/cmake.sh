#!/usr/bin/env bash

## Install CMake

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r cmake
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/cmake
mkdir -p $HOME/.local/src/cmake
cd $HOME/.local/src/cmake

## Download
export CMAKE_URL="https://cmake.org/files/LatestRelease/cmake-3.20.3.tar.gz"
wget ${CMAKE_URL}

## Extract
tar -xzvf cmake-*.tar.gz
cd $HOME/.local/src/cmake/cmake-*/
#mkdir build
#cd build/

## Install
./configure --prefix=$HOME/.local/usr
make
porg -lD "make install"

## Check
porg cmake
cd $HOME
