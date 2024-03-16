#!/bin/sh

npm update  --global
npm install --global npm
npm --version
npm install --global \
    yarn eslint neovim gtop \
    prettier @fsouza/prettierd
npm list    --global
