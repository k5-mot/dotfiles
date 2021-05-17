#!/usr/bin/env zsh

## Install anyenv
## Setup anyenv



## Install plugins for rbenv.
if [ ! -e $ANYENV_ROOT/envs/rbenv/plugins/ruby-build ]; then
  git clone https://github.com/rbenv/ruby-build.git $ANYENV_ROOT/envs/rbenv/plugins/ruby-build
fi
if [ ! -e $ANYENV_ROOT/envs/rbenv/plugins/rbenv-update ]; then
  git clone https://github.com/rkh/rbenv-update.git $ANYENV_ROOT/envs/rbenv/plugins/rbenv-update
fi
if [ ! -e $ANYENV_ROOT/envs/rbenv/plugins/rbenv-default-gems ]; then
  git clone https://github.com/rbenv/rbenv-default-gems.git $ANYENV_ROOT/envs/rbenv/plugins/rbenv-default-gems
fi

## Install plugins for nodenv.
if [ ! -e $ANYENV_ROOT/envs/nodenv/plugins/node-build ]; then
  git clone https://github.com/nodenv/node-build.git $ANYENV_ROOT/envs/nodenv/plugins/node-build
fi
if [ ! -e $ANYENV_ROOT/envs/nodenv/plugins/nodenv-update ]; then
  git clone https://github.com/nodenv/nodenv-update.git $ANYENV_ROOT/envs/nodenv/plugins/nodenv-update
fi

## Install plugins for luaenv.
if [ ! -e $ANYENV_ROOT/envs/luaenv/plugins/lua-build ]; then
  git clone https://github.com/cehoffman/lua-build.git $ANYENV_ROOT/envs/luaenv/plugins/lua-build
fi

## Install plugins for plenv.
if [ ! -e $ANYENV_ROOT/envs/plenv/plugins/perl-build ]; then
  git clone https://github.com/tokuhirom/Perl-Build.git $ANYENV_ROOT/envs/plenv/plugins/perl-build
fi
#if [ -e $ANYENV_ROOT/envs/plenv/plugins/perl-build ]; then
#  cd $ANYENV_ROOT/envs/plenv/plugins/perl-build
#  git pull
#  cd $HOME
#fi
#if [ ! -e $ANYENV_ROOT/envs/plenv/plugins/perl-install ]; then
#  rm -rf ~/.anyenv/envs/plenv/plugins/perl-build
#  git clone https://github.com/skaji/perl-install.git $ANYENV_ROOT/envs/plenv/plugins/perl-install
#fi
#if [ ! -e $ANYENV_ROOT/envs/plenv/plugins/plenv-download ]; then
#  git clone https://github.com/skaji/plenv-download.git $ANYENV_ROOT/envs/plenv/plugins/plenv-download
#fi


rbenv update
nodenv update
#luaenv update
#plenv update

## Get latest version of each environment.

export RBENV_RUBY_VERSION=$(rbenv install --list-all | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
export NODENV_NODEJS_VERSION=$(nodenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
export LUAENV_LUA_VERSION=$(luaenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export PLENV_PERL_VERSION=$(plenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | head -1 | sed 's/^[ \t]*//')

## Set cpanm options for plenv.
#export PERL_CPANM_OPT="--prompt --reinstall -l ~/perl --mirror http://cpan.cpantesters.org"

## Display latest version of each environment.
echo ''

echo "Ruby    : $RBENV_RUBY_VERSION"
echo "Node.js : $NODENV_NODEJS_VERSION"
echo "Lua     : $LUAENV_LUA_VERSION"
echo "Perl    : $PLENV_PERL_VERSION"
echo ''

## Install latest version of each environment.

CONFIGURE_OPTS="--enable-shared" rbenv install --skip-existing $RBENV_RUBY_VERSION
CONFIGURE_OPTS="--enable-shared" nodenv install --skip-existing $NODENV_NODEJS_VERSION
CONFIGURE_OPTS="--enable-shared" luaenv install --skip-existing $LUAENV_LUA_VERSION
#CONFIGURE_OPTS="--enable-shared" plenv install $PLENV_PERL_VERSION

## Check versions.
rbenv versions
nodenv versions
luaenv versions
plenv versions



## Install packages of Ruby
rbenv global $RBENV_RUBY_VERSION
gem update
gem update --system
gem install neovim
gem list

## Install packages of Node.js
nodenv global $NODENV_NODEJS_VERSION
npm update
npm install --global npm
npm install --global neovim
npm install --global yarn
npm list --global

## Lua
luaenv global $LUAENV_LUA_VERSION
lua -v

## Install packages of Perl
plenv global $PLENV_PERL_VERSION
plenv install-cpanm
#cpanm Unicode::Japanese
#cpanm -n Neovim::Ext

