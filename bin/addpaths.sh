#!/bin/sh
for str in `find $1 -type d -print
do
	export PATH=$PATH:$str
done
