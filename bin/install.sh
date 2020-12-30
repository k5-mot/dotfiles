#!/bin/bash

## dotfiles PATH
DOTPATH="$HOME/dotfiles"

## Check existence of command
has() {
  type "$1" > /dev/null 2>&1
}

initialize() {
  if [ ! -d ${DOTPATH} ]; then

  ## Download dotfiles
  if has "git"; then
    git clone https://github.com/k5-mot/dotfiles.git ${DOTPATH}
  elif has "curl" || has "wget"; then
    TARBALL="https://github.com/k5-mot/dotfiles/archive/master.tar.gz"
    if has "curl"; then
      curl -L ${TARBALL} -o master.tar.gz
    else
      wget ${TARBALL}        
    fi
    tar -zxvf master.tar.gz
    rm -f master.tar.gz
    mv -f dotfiles-master "${DOTPATH}"
  else
    echo "Required: git, curl or wget"
    exit 1
  fi
  else
    echo "Failed to install." 
    echo "dotfiles already exists."
    exit 1
  fi
}

deploy () {
  ## Deploy dotfiles.
  cd ${DOTPATH}
  for f in *; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitmodules" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == "README.md" ]] && continue
    [[ "$f" == "bin/install.sh" ]] && continue

    ln -snf $DOTPATH/"$f" $HOME/".$f"
    echo "Installed: $f"
  done
}


## Initialize & Deploy
initialize()
deploy()