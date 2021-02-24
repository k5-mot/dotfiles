#!/usr/bin/env zsh

## If use tmux, not read .zshrc
#if [[ -z $TMUX ]]; then
#  tmux new-session
#  exit
#fi

## Setup VcXsrv for WSL
if [ "$(uname 2> /dev/null)" = Linux ]; then
  if [[ "$(uname -r 2> /dev/null)" = *microsoft* ]]; then
    export LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    export DISPLAY=$LOCAL_IP:0
    export LIBGL_ALWAYS_INDIRECT=1
  fi
fi

## Create zsh cache directory.
if [ ! -e $ZDOTCACHE ]; then
  mkdir -p $ZDOTCACHE
fi

## History {{{
## Define history file.
export HISTFILE=$ZDOTCACHE/.zsh_history
## Define command size in history.
export HISTSIZE=100
## Define command size in history file.
export SAVEHIST=1000
## Delete old duplication of history.
setopt hist_ignore_all_dups
## Delete duplication of previous command.
setopt hist_ignore_dups
## Share history file.
setopt share_history
## Append history file, not resave.
setopt append_history
## Append history file each entering command.
setopt inc_append_history
## Save current time in history file.
setopt extended_history
## Not save command in history.
setopt hist_no_store
## Save without blank.
setopt hist_reduce_blanks
## Active cdr command. (cd recent file command)
autoload -Uz chpwd_recent_dirs
autoload -Uz cdr
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-file $ZDOTCACHE/chpwd-recent-dirs
## Search function
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
## }}}

## Color {{{
## Set SHELL
if [[ -z "$SHELL" ]]; then
  SHELL="$(command -v zsh)"
  export SHELL
fi
## Use colors
autoload -Uz colors
colors
## Remove file mark.
unsetopt list_types
## Color list
#local DEFAULT=$'%{^[[m%}'$
#local RED=$'%{^[[1;31m%}'$
#local GREEN=$'%{^[[1;32m%}'$
#local YELLOW=$'%{^[[1;33m%}'$
#local BLUE=$'%{^[[1;34m%}'$
#local PURPLE=$'%{^[[1;35m%}'$
#local LIGHT_BLUE=$'%{^[[1;36m%}'$
#local WHITE=$'%{^[[1;37m%}'$
## }}}

## Completion {{{
## Highlight completion.
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'"$DEFAULT"
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'"$DEFAULT"
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'"$DEFAULT"
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'"$DEFAULT"
# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
## LS_COLORS
if [[ -f $ZDOTDIR/.dircolors && -x `which dircolors` ]]; then
  eval `dircolors -b $ZDOTDIR/.dircolors`
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
## Define demiter of words.
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-. /=;@:{},|"
zstyle ':zle:*' word-style unspecified
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
# formatting and messages
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*:descriptions' format '%B%d%b'
#zstyle ':completion:*:messages' format '%d'
#zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
#zstyle ':completion:*' group-name ''
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)
export hosts
zstyle '*' hosts $hosts
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
  '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
## }}}

## Keybinding {{{
## Set up Vim key bindings.
bindkey -v
## Set up Emacs key bindings.
#bindkey -e
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^W' backward-kill-word
# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|
## }}}

## Prompt {{{
setopt prompt_subst
## Set prompts
#export PROMPT="
#%F{green}%n%f@%F{blue}%M%f:%F{cyan}%~%f
#$ "
#export PROMPT="
#%F{green}%n%f@%F{blue}%m%f$ "
#export PROMPT="%F{green}%n%f@%F{blue}%m%f$ "
#export PROMPT="%F{green}$%f "
#case $(whoami) in
#  'root')
#    export PROMPT="%F{cyan}%~%f
#%F{red}#%f "
#    ;;
#  *)
#    export PROMPT="%F{cyan}%~%f
#%F{green}$%f "
#    ;;
#esac
case $(whoami) in
  'root')
    export PROMPT="%F{red}#%f "
    ;;
  *)
    export PROMPT="%F{green}$%f "
    ;;
esac
export PROMPT2=
## }}}

## git設定
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
#zstyle ':vcs_info:*' formats "%F{green}(%s)-%c%u[%b]%f"
#zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
  vcs_info
}
#RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
#RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
#RPROMPT='${vcs_info_msg_0_}'
RPROMPT=""

## Others {{{
# ディレクトリ選択時、最後の/を残す
setopt no_auto_remove_slash
# Set/unset  shell options
setopt notify globdots correct pushdtohome cdablevars autolist
setopt correctall autocd recexact longlistjobs
setopt autoresume histignoredups pushdsilent noclobber
setopt autopushd pushdminus extendedglob rcquotes mailwarning
setopt ignoreeof
setopt no_beep
setopt nolistbeep
unsetopt bgnice autoparamslash
# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
# set up tetris
autoload -Uz tetris
zle -N tetris
#bindkey '...' tetris
# set up tetris 1
autoload -Uz tetriscurses
#alias tetris=tetriscurses
## }}}


if [ $OSTYPE = linux-gnu -o $OSTYPE = linux ]; then

  ## Set up homebrew
  export HOMEBREW_ROOT=$HOME/.linuxbrew
  if [ -e $HOMEBREW_ROOT ]; then
    #export PATH=$HOMEBREW_ROOT/bin:$PATH
    #export PATH=$HOMEBREW_ROOT/sbin:$PATH
    #export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
    #export INFOPATH=$HOMEBREW_ROOT/share/info:$INFOPATH
    #export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib:$LD_LIBRARY_PATH
    #export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS
    ## Optional
    #export HOMEBREW_NO_ENV_FILTERING=1
    #export HOMEBREW_DEVELOPER=1
    #export HOMEBREW_CURL_PATH=$HOME/.local/bin/curl
    #export HOMEBREW_GIT_PATH=$HOME/.local/bin/git

    #eval "$($HOMEBREW_ROOT/bin/brew shellenv)"
  fi

fi

### Programming environament {{{
## Set up anyenv.
export ANYENV_ROOT=$HOME/.anyenv
if [ -e $ANYENV_ROOT ]; then
  export PATH=$ANYENV_ROOT/bin:$PATH
  if command -v anyenv 1>/dev/null 2>&1; then
    eval "$(anyenv init -)"
  fi
fi
## Set up rust.
export CARGO_ROOT=$HOME/.cargo
if [ -e $CARGO_ROOT ]; then
  export PATH=$CARGO_ROOT/bin:$PATH
fi
## Set up golang.
export GOPATH=$HOME/.golang
if [ -e $GOPATH ]; then
  export PATH=$GOPATH/bin:$PATH
fi
## Set up pyenv
#  export PYENV_ROOT=$HOME/.pyenv
#if [ -e "$HOME/.pyenv" ]; then
#  export PATH=$PYENV_ROOT/bin:$PATH
#  if command -v pyenv 1>/dev/null 2>&1; then
#    eval "$(pyenv init -)"
#    eval "$(pyenv virtualenv-init -)"
#  fi
#fi
## Set up rbenv
#  export RBENV_ROOT=$HOME/.rbenv
#if [ -e "$HOME/.rbenv" ]; then
#  export PATH=$RBENV_ROOT/bin:$PATH
#  if command -v rbenv 1>/dev/null 2>&1; then
#    eval "$(rbenv init -)"
#  fi
#fi
## Set up nodenv
#  export NODENV_ROOT=$HOME/.nodenv
#if [ -e "$HOME/.nodenv" ]; then
#  export PATH=$NODENV_ROOT/bin:$PATH
#  if command -v nodenv 1>/dev/null 2>&1; then
#    eval "$(nodenv init -)"
#  fi
#fi
### }}}
GOPATH=$HOME/.golang
function _update_ps1() {
  PS1="$($GOPATH/bin/powerline-go -error $?)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Read local file
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

# Read config file for Antigen.
#if [ -f $ZDOTDIR/.zshrc_antigen ]; then
#  source $ZDOTDIR/.zshrc_antigen
#fi
if [ -f $ZDOTDIR/zplug.zsh ]; then
  source $ZDOTDIR/zplug.zsh
fi

# Compile .zshrc only once at first.
if [ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]; then
  zcompile $ZDOTDIR/.zshrc
fi

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
