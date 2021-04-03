#!/usr/bin/env zsh

## Install pyenv
## Setup pyenv
## Install basic packages by pip


## Install pyenv
if [ ! -e $PYENV_ROOT ]; then
  git clone https://github.com/yyuu/pyenv.git $PYENV_ROOT
fi
cd $PYENV_ROOT
git pull

## Install pyenv-virtualenv
if [ ! -e $PYENV_PLUGINS/pyenv-virtualenv ]; then
  git clone https://github.com/yyuu/pyenv-virtualenv $PYENV_PLUGINS/pyenv-virtualenv
fi
cd $PYENV_PLUGINS/pyenv-virtualenv
git pull

## Install pyenv-ccache
if [ ! -e $PYENV_PLUGINS/pyenv-ccache ]; then
  git clone https://github.com/yyuu/pyenv-ccache $PYENV_PLUGINS/pyenv-ccache
fi
cd $PYENV_PLUGINS/pyenv-ccache
git pull

## Install pyenv-pip-update
if [ ! -e $PYENV_PLUGINS/pyenv-pip-update ]; then
  git clone https://github.com/massongit/pyenv-pip-update $PYENV_PLUGINS/pyenv-pip-update
fi
cd $PYENV_PLUGINS/pyenv-pip-update
git pull

## Setup pyenv
cd $HOME/
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## Configure pyenv variable
export PYENV_PYTHON3_VERSION=$(pyenv install --list | grep -v '[a-zA-Z]' | grep -e '3\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export PYENV_PYTHON2_VERSION=$(pyenv install --list | grep -v '[a-zA-Z]' | grep -e '2\.[0-9]*\.[0-9]*' | tail -1 | sed 's/^[ \t]*//')
export PYENV_ROOT=$HOME/.pyenv
export PYENV_PLUGINS=$PYENV_ROOT/plugins

## Install Python2
pyenv install --skip-existing $PYENV_PYTHON2_VERSION
pyenv rehash

## Install Python3
pyenv install --skip-existing $PYENV_PYTHON3_VERSION
pyenv rehash

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
pip install numpy
pip install scipy
pip install neovim
pip install openpyxl
pip-review --auto
pip list
