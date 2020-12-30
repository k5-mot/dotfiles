#!/bin/bash

## Install pyenv
## Setup pyenv
## Install basic packages by pip

## Configure pyenv variable
export PYENV_PYTHON3_VERSION=3.8.6
export PYENV_PYTHON2_VERSION=2.7.18
export PYENV_ROOT=$HOME/.pyenv
export PYENV_PLUGINS=$PYENV_ROOT/plugins

## Install pyenv
git clone https://github.com/yyuu/pyenv.git $PYENV_ROOT
cd $PYENV_ROOT
git pull

## Install pyenv-virtualenv
git clone https://github.com/yyuu/pyenv-virtualenv $PYENV_PLUGINS/pyenv-virtualenv
cd $PYENV_PLUGINS/pyenv-virtualenv
git pull

## Install pyenv-ccache
git clone https://github.com/yyuu/pyenv-ccache $PYENV_PLUGINS/pyenv-ccache
cd $PYENV_PLUGINS/pyenv-ccache
git pull

## Install pyenv-pip-update
git clone https://github.com/massongit/pyenv-pip-update $PYENV_PLUGINS/pyenv-pip-update
cd $PYENV_PLUGINS/pyenv-pip-update
git pull

## Setup pyenv
cd $HOME/
$PYENV_ROOT/bin/pyenv init

## Install Python2
pyenv install $PYENV_PYTHON2_VERSION
pyenv rehash

## Install Python3
pyenv install $PYENV_PYTHON3_VERSION
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
pip-review --auto
pip list
