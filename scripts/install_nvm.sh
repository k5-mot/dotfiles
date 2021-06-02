#!/usr/bin/env bash

set -eu

export NVM_DIR="$HOME/.nvm"

rm -rf ${NVM_DIR}

git clone https://github.com/nvm-sh/nvm.git ${NVM_DIR}
cd ${NVM_DIR}

git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`

chmod 755 ${NVM_DIR}/nvm.sh
\. "${NVM_DIR}/nvm.sh"

#NODEJS_VERSION=14.17.0
cd $HOME

nvm install 'lts/*' --reinstall-packages-from=current
nvm install-latest-npm
exec $SHELL -l

