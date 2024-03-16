#!/usr/bin/env zsh

### Env {{{
## Global Settings
export GLOBAL_ENV_FILE="${HOME}/.config/env"
if [ -e "${GLOBAL_ENV_FILE}" ]; then
  source "${GLOBAL_ENV_FILE}"
fi

## Local Settings
export LOCAL_ENV_FILE="${HOME}/.env"
if [ -e "${LOCAL_ENV_FILE}" ]; then
  source "${LOCAL_ENV_FILE}"
fi
### }}}


### Env {{{
## Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s
umask 022

## 履歴ファイルの保存先
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
## メモリに保存される履歴件数
export HISTSIZE=100
## 履歴ファイルに保存される履歴件数
export SAVEHIST=100000
### }}}


### Fast-Loading by Compile {{{
if [ "${ZDOTDIR}/.zshenv" -nt "${ZDOTDIR}/.zshenv.zwc" ]; then
  zcompile "${ZDOTDIR}/.zshenv"
fi
### }}}
