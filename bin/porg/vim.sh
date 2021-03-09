#!/usr/bin/env bash

## vim

cd $HOME
cd $HOME/.local/src
if (type "porg" > /dev/null 2>&1); then
  porg -r vim
fi
rm -rf $HOME/.local/src/vim
git clone --verbose --progress https://github.com/vim/vim.git
cd $HOME/.local/src/vim

export PYENV_PYTHON3_VERSION=$(pyenv versions | grep -e '3\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export PYENV_PYTHON2_VERSION=$(pyenv versions | grep -e '2\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export RBENV_RUBY_VERSION=$(rbenv versions | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export PLENV_PERL_VERSION=$(plenv versions | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')
export LUAENV_LUA_VERSION=$(luaenv versions | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1 | sed 's/([^)]*)//g' | sed 's/[ \t*]//g')

#--enable-gui=gtk2 \
#--with-luajit \
#--enable-tclinterp \

LDFLAGS="-Wl,-rpath=$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON2_VERSION/lib:$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON3_VERSION/lib" ./configure \
--enable-cscope \
--enable-terminal \
--enable-fontset \
--enable-multibyte \
--enable-nls \
--enable-fail-if-missing \
--enable-python3interp \
--enable-pythoninterp \
--enable-rubyinterp \
--enable-luainterp \
--with-features=huge \
--enable-xim \
--enable-gpm \
--with-x \
--enable-gui=auto \
--with-python3-command=$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON3_VERSION/bin/python3 \
--with-python-command=$HOME/.anyenv/envs/pyenv/versions/$PYENV_PYTHON2_VERSION/bin/python2 \
--with-ruby-command=$HOME/.anyenv/envs/rbenv/versions/$RBENV_RUBY_VERSION/bin/ruby \
--with-lua-prefix=$HOME/.anyenv/envs/luaenv/versions/$LUAENV_LUA_VERSION \
--prefix=$HOME/.local/usr
#--enable-gui=yes \
#--enable-xim \
#--with-x \
#--enable-gpm \
make
export VIM_VERSION=$(./src/vim --version | head -1 | awk '{print $5}')

porg -lp vim-$VIM_VERSION make install
porg vim
cd $HOME
