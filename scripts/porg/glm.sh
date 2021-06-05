#!/usr/bin/env bash

## Install GLM

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r glm
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/glm
cd $HOME/.local/src/

## Download
git clone https://github.com/g-truc/glm.git
cd $HOME/.local/src/glm

## Install
porg -lD  "cp -rf $HOME/.local/src/glm/glm $HOME/.local/usr/include"
porg -lD+ "cp -rf $HOME/.local/src/glm/doc $HOME/.local/usr/share/doc/glm"

## Check
porg glm
cd $HOME
