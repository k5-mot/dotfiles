#!/bin/bash

## dotfiles PATH
DOTPATH="$HOME/dotfiles"
OS="linux"
SELECTPATH="$DOTPATH/$OS/"

## Check existence of command
has() {
  type "$1" > /dev/null 2>&1
}

## Download dotfiles
initialize() {
  if [ ! -d ${DOTPATH} ]; then
    echo 'Download dot files in your home directory...'
    if has "git"; then
      git clone -v https://github.com/k5-mot/dotfiles.git ${DOTPATH}
    elif has "curl"; then
      TARBALL="https://github.com/k5-mot/dotfiles/archive/master.tar.gz"
      curl -L ${TARBALL} -o master.tar.gz
      tar -zxvf master.tar.gz
      rm -f master.tar.gz
      mv -f dotfiles-master "${DOTPATH}"
    elif has "wget"; then
      TARBALL="https://github.com/k5-mot/dotfiles/archive/master.tar.gz"
      wget ${TARBALL}
      tar -zxvf master.tar.gz
      rm -f master.tar.gz
      mv -f dotfiles-master "${DOTPATH}"
    else
      echo "Required: git, curl or wget"
      exit 1
    fi
  else
    echo "Failed: dotfiles already exists."
    exit 1
  fi
}

## Deploy dotfiles.
deploy () {
  echo 'Install dotfiles to home directory.'
  for f in `\find "${SELECTPATH}" -type f`
  do
    filename=${f/$SELECTPATH/}
    ln -snfv $f "$HOME/$filename"
  done
}

## Initialize & Deploy
if [ "$1" = "deploy" -o "$1" = "d" ]; then
  deploy
elif [ "$1" = "init" -o "$1" = "i" ]; then
  initialize
else 
  initialize
  deploy
fi