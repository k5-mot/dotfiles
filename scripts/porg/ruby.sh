#!/usr/bin/env bash

## Ruby

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r ruby
fi

rm -rf $HOME/.local/src/ruby
mkdir -p $HOME/.local/src/ruby
cd $HOME/.local/src/ruby

wget http://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.1.tar.gz
tar -zxvf ruby-*.tar.gz
cd ruby-*/

./configure --prefix=$HOME/.local/usr
make
porg -lD make install
porg ruby

gem update
gem install neovim
gem list

cd $HOME
