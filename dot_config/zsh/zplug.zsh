#!/usr/bin/env zsh

export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

## Install zplug
if [[ ! -e $ZPLUG_HOME ]]; then
git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

## Initialize
source "$ZPLUG_HOME/init.zsh"

## Plugin list
zplug "zplug/zplug", hook-build: "zplug --self-manage"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/emoji-cli"
zplug "mrowa44/emojify", as:command
zplug "bilelmoussaoui/flatpak-zsh-completion", defer:2
zplug "chrissicool/zsh-256color"
zplug "supercrabtree/k"
zplug "starship/starship", as:command

# Install plugins
if ! zplug check --verbose; then
zplug install
# printf "Install? [y/N]: "
# if read -q; then
#   echo; zplug install
# fi
fi
zplug load

export EMOJI_CLI_KEYBIND="^f"
