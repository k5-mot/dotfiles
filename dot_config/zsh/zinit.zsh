#!/usr/bin/env zsh

export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

### Added by Zinit's installer
if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "${ZINIT_HOME:h}" && command chmod g-rwX "${ZINIT_HOME:h}"
    command git clone --branch=v3.15.0 https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# 認証が必要な個人用リポジトリは、現在の取得経路を優先する。
zinit light k5-mot/zsh-completions
zinit ice ver"v0.7.1"
zinit light zsh-users/zsh-autosuggestions
zinit ice atclone"git checkout --detach 559fee48bb74b75cec8b9887f8f3e046f01d5d8f" atpull"%atclone"
zinit light chrissicool/zsh-256color
zinit ice ver"v1.56"
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice atclone"git checkout --detach 55d8e061d52f4aa26aac8915d920d3b4f5649429" atpull"%atclone"
zinit light zdharma-continuum/history-search-multi-word
zinit ice ver"0.0.5"
zinit light supercrabtree/k
zinit ice atclone"git checkout --detach 0fbb2e48e07218c5a2776100a4c708b21cb06688" atpull"%atclone"
zinit light b4b4r07/emoji-cli
# zinit light mnowotnik/fzshell
zinit ice ver"7.5.0" as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras
