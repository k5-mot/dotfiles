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

zinit ice ver"v0.7.1"
zinit light zsh-users/zsh-autosuggestions
zinit ice ver"v1.56"
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice ver"0.0.5"
zinit light supercrabtree/k
# zinit light mnowotnik/fzshell
zinit ice ver"7.5.0" as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras
