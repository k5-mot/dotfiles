#!/usr/bin/env bash

# vim
cd $HOME/.local/src
if [ -d $HOME/.local/src/vim ]
  rm -rf $HOME/.local/src/vim
fi
git clone --verbose --progress https://github.com/vim/vim.git
cd vim/
#--enable-gui=gtk2 \
#--with-luajit \
#export PYENV_PYTHON3_VERSION=$(pyenv versions | grep -v '[a-zA-Z]' | grep -e '3\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
#export PYENV_PYTHON2_VERSION=$(pyenv versions | grep -v '[a-zA-Z]' | grep -e '2\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export PYENV_PYTHON3_VERSION=$(pyenv versions | grep -e '3\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export PYENV_PYTHON2_VERSION=$(pyenv versions | grep -e '2\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export RBENV_RUBY_VERSION=$(rbenv versions | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export LUAENV_LUA_VERSION=$(luaenv versions | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')

LDFLAGS="-Wl,-rpath=$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON2_VERSION/lib:$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON3_VERSION/lib" ./configure \
--enable-cscope \
--enable-terminal \
--enable-fontset \
--enable-multibyte \
--enable-nls \
--enable-fail-if-missing \
--enable-tclinterp \
--enable-python3interp \
--enable-pythoninterp \
--enable-rubyinterp \
--enable-luainterp \
--with-features=huge \
--with-python3-command=$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON3_VERSION/bin/python3 \
--with-python-command=$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON2_VERSION/bin/python2 \
--with-ruby-command=$HOME/.anyenv/envs/rbenv/versions/3.0.0/bin/ruby \
--with-lua-prefix=$HOME/.anyenv/envs/luaenv/versions/5.4.2 \
--prefix=$HOME/.local/usr
make
porg -lp vim-8.2 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg vim
