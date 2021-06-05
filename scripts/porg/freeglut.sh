#!/usr/bin/env bash

## Install FreeGLUT

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r freeglut
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/freeglut
mkdir $HOME/.local/src/freeglut
cd $HOME/.local/src/freeglut

## Download
export GLUT_URL="https://sourceforge.net/projects/freeglut/files/latest/download"
#export GLUT_URL="https://sourceforge.net/projects/freeglut/files/freeglut/3.2.1/freeglut-3.2.1.tar.gz/download"
wget --content-disposition ${GLUT_URL}

## Extract
tar -xzvf freeglut-*.tar.gz
cd $HOME/.local/src/freeglut/freeglut-*/

## Install
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local/usr/
make
porg -lD "make prefix=$HOME/.local/usr install"

## Check
porg freeglut
cd $HOME
