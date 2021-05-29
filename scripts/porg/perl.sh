#!/usr/bin/env bash

## Perl
set -x
cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r perl
fi

rm -rf $HOME/.local/src/perl
mkdir -p $HOME/.local/src/perl
cd $HOME/.local/src/perl

wget https://www.cpan.org/src/5.0/perl-5.34.0.tar.gz
tar -zxvf perl-*.tar.gz
cd perl-*/

sh Configure \
  -Dprefix=$HOME/.local/usr \
  -des \
  -Duseshrplib 
#  -DDEBUGGING=-g
make
make test
#porg -lD make install
#porg perl
cd $HOME
