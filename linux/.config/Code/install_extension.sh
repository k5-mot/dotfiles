#!/bin/sh

## Install extensions for VSCode.
filename="./extension-list"
echo $1
if [ -e $1 ]; then
	filename=$1
fi	

cat ${filename} | while read line
do
  code --install-extension ${line}
done
