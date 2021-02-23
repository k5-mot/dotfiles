#!/bin/sh

## Install extensions for VSCode.
filename="./extension-list"
cat ${filename} | while read line
do
  code --install-extension ${line}
done
