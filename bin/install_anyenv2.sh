#!/usr/bin/env zsh

## Install anyenv
## Setup anyenv

## Install pyenv-update for pyenv.
if [ ! -e $ANYENV_ROOT/envs/pyenv/plugins/pyenv-update ]; then
  git clone git://github.com/yyuu/pyenv-update.git $ANYENV_ROOT/envs/pyenv/plugins/pyenv-update
fi
if [ ! -e $ANYENV_ROOT/envs/pyenv/plugins/pyenv-virtualenv ]; then
  git clone https://github.com/yyuu/pyenv-virtualenv $ANYENV_ROOT/envs/pyenv/plugins/pyenv-virtualenv
fi
if [ ! -e $ANYENV_ROOT/envs/pyenv/plugins/pyenv-pip-update ]; then
  git clone https://github.com/massongit/pyenv-pip-update $ANYENV_ROOT/envs/pyenv/plugins/pyenv-pip-update
fi

if [ ! -e $ANYENV_ROOT/envs/rbenv/plugins/ruby-build ]; then
  git clone git://github.com/sstephenson/ruby-build.git $ANYENV_ROOT/envs/rbenv/plugins/ruby-build
fi

if [ ! -e $ANYENV_ROOT/envs/nodenv/plugins/node-build ]; then
  git clone https://github.com/nodenv/node-build.git $ANYENV_ROOT/envs/nodenv/plugins/node-build
fi
if [ ! -e $ANYENV_ROOT/envs/nodenv/plugins/nodenv-update ]; then
  git clone https://github.com/nodenv/nodenv-update.git $ANYENV_ROOT/envs/nodenv/plugins/nodenv-update
fi

if [ ! -e $ANYENV_ROOT/envs/luaenv/plugins/lua-build ]; then
  git clone git://github.com/cehoffman/lua-build.git $ENYENV_ROOT/envs/luaenv/plugins/lua-build
fi

if [ ! -e $ANYENV_ROOT/envs/plenv/plugins/perl-build ]; then
  git clone git://github.com/tokuhirom/Perl-Build.git $ANYENV_ROOT/envs/plenv/plugins/perl-build/
fi

anyenv update
pyenv update
#rbenv update
nodenv update
#luaenv update
#plenv update

## Get latest version of each environment.
export PYENV_PYTHON3_VERSION=$(pyenv install --list | grep -v '[a-zA-Z]' | grep -e '3\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export PYENV_PYTHON2_VERSION=$(pyenv install --list | grep -v '[a-zA-Z]' | grep -e '2\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export RBENV_RUBY_VERSION=$(rbenv install --list-all | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
export NODENV_NODEJS_VERSION=$(nodenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
export LUAENV_LUA_VERSION=$(luaenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export PLENV_PERL_VERSION=$(plenv install --list | grep -v '[a-zA-Z]' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | head -1 | sed 's/^[ \t]*//')

## Display latest version of each environment.
echo ''
echo "Python3 : $PYENV_PYTHON3_VERSION"
echo "Python2 : $PYENV_PYTHON2_VERSION"
echo "Ruby    : $RBENV_RUBY_VERSION"
echo "Node.js : $NODENV_NODEJS_VERSION"
echo "Lua     : $LUAENV_LUA_VERSION"
echo "Perl    : $PLENV_PERL_VERSION"
echo ''

## Install latest version of each environment.
CONFIGURE_OPTS="--enable-shared" pyenv install --skip-existing $PYENV_PYTHON3_VERSION
CONFIGURE_OPTS="--enable-shared" pyenv install --skip-existing $PYENV_PYTHON2_VERSION
CONFIGURE_OPTS="--enable-shared" rbenv install --skip-existing $RBENV_RUBY_VERSION
CONFIGURE_OPTS="--enable-shared" nodenv install --skip-existing $NODENV_NODEJS_VERSION
CONFIGURE_OPTS="--enable-shared" luaenv install --skip-existing $LUAENV_LUA_VERSION
plenv install $PLENV_PERL_VERSION

## Check versions.
pyenv versions
rbenv versions
nodenv versions
luaenv versions
#plenv versions

## Install packages of Python2
pyenv global $PYENV_PYTHON2_VERSION
pip install --upgrade pip
pip install pip-review
pip install neovim
pip-review --auto
pip list

## Install packages of Python3
pyenv global $PYENV_PYTHON3_VERSION
pip install --upgrade pip
pip install pip-review
pip install matplotlib
pip install numpy
pip install scipy
pip install neovim
pip-review --auto
pip list

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
npm -g list

## Lua
luaenv global $LUAENV_LUA_VERSION
lua -v

## Install packages of Perl
plenv global $PLENV_PERL_VERSION
cpanm -n Neovim::Ext
