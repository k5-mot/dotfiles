#!/usr/bin/env zsh

## If use tmux, not read .zshrc
#if [[ -z $TMUX ]]; then
#  tmux new-session
#  exit
#fi

## Create zsh cache directory.
if [ ! -e $ZDOTCACHE ]; then
  mkdir -p $ZDOTCACHE
fi

### Alias {{{
# Set up aliases
alias mv='nocorrect mv -i'       # no spelling correction on mv
#alias cp='nocorrect cp -i'       # no spelling correction on cp
alias rm='nocorrect rm -i'       # no spelling correction on rm
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias x=exit
alias grep='grep --color=auto'
#alias wget="wget --hsts-file $HOME/.cache/wget/wget-hsts"
alias osinfo='cat /etc/*-release'
alias xsel='xsel --logfile=$HOME/.cache/xsel/xsel.log'

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
### }}}

### Function {{{
function path_append() {
  path_remove $1;
  export PATH="$PATH:$1";
}

function path_prepend() {
  path_remove $1;
  export PATH="$1:$PATH";
}

function path_remove() {
  export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`;
}

# Shell functions
function setenv() {
  typeset -x "${1}${1:+=}${(@)argv[2,$#]}"
}  # csh compatibility

function freload() {
  while (( $# )); do;
    unfunction $1;
    autoload -U $1;
    shift;
  done
}

function refresh_zsh() {
  exec $SHELL -l
}

function refresh_gnome() {
  rm -rf ~/.gnome
  rm -rf ~/.gnome-desktop
  rm -rf ~/.gconf
  rm -rf ~/.gconfd
}

# Benchmark zsh.
function benchmark_zsh() {
  for i in $(seq 1 10); do
    time ( zsh -i -c exit )
  done
}

# check powerline
function check_powerline() {
  echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
}

# check 256 colors v1
function check_colors() {
  for c in {000..255}; do
    #echo -n "\e[[30;48;5${c}m\e[[38;5;${((255 - %c))}m $c\e[[0m"
    echo -n "\e[31;48;5;${c}m\e[38;5;${$((255 - $c))}m $c \e[0m"
    if [ $(($c % 16)) -eq 15 ]; then
      echo
    fi
    #[ $(($c%16)) -eq 15 ] && echo
  done
  echo
}

# Check path.
function check_path() {
  echo "PATH"
  echo $PATH | sed -e "s/:/\n/g"
}

# Check library path.
function check_libpath() {
  echo "LD_LIBRARY_PATH"
  echo $LD_LIBRARY_PATH | sed -e 's/:/\n/g'
  echo "LIBRARY_PATH"
  echo $LIBRARY_PATH | sed -e 's/:/\n/g'
}

# Check include path
function check_includepath() {
  echo "CPATH"
  echo $CPATH | sed -e 's/:/\n/g'
  echo "C_INCLUDE_PATH"
  echo $C_INCLUDE_PATH | sed -e 's/:/\n/g'
  echo "CPLUS_INCLUDE_PATH"
  echo $CPLUS_INCLUDE_PATH | sed -e 's/:/\n/g'
}

# check 256 colors v2
function check_colors1() {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
      r = 255-(colnum*255/76);
      g = (colnum*510/76);
      b = (colnum*255/76);
      if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
      }
    printf "\n";
  }'
}

function check_zsh() {
   for i in $(seq 1 10); do
     time zsh -i -c exit
   done
}
### }}}

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
#if [[ -f $ZDOTDIR/.dircolors && -x `which dircolors` ]]; then
#  eval `dircolors -b $ZDOTDIR/.dircolors`
#  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#fi
if [[ -f $HOME/.config/.dircolors && -x `which dircolors` ]]; then
  eval `dircolors -b $HOME/.config/.dircolors`
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

# suggestion
bindkey '^ ' autosuggest-accept
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
#function precmd() {
#  if [ ! -z $TMUX ]; then
#    tmux refresh-client -S
#  fi
#  vcs_info
#}
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  else
    dir="%F{cyan}%K{black} %~ %k%f"
    if git_status=$(git status 2>/dev/null ); then
      git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
       case $git_status in
        *Changes\ not\ staged* ) state=$'%{\e[30;48;5;013m%}%F{black} ± %f%k' ;;
        *Changes\ to\ be\ committed* ) state="%K{blue}%F{black} + %k%f" ;;
        * ) state="%K{green}%F{black} ✔ %f%k" ;;
      esac
      if [[ $git_branch = "master" ]]; then
        git_info="%K{black}%F{blue}⭠ ${git_branch}%f%k ${state}"
      else
        git_info="%K{black}⭠ ${git_branch}%f ${state}"
      fi
    else
      git_info=""
    fi
  fi
}


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

if [ ! -z $VIMRUNTIME ]; then
  #PROMPT=$'%(?,,%F{red}%K{black} ✘%f %f|%k)${root}${dir}%K{black}%F{blue}> %f%k'
  case $(whoami) in
    'root')
      export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{red}#%f " ;;
    *)
      export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{green}$%f " ;;
  esac
  export RPROMPT="${git_info}"
elif [ ! -z $TMUX ]; then
  #PROMPT=$'%(?,,%F{red}%K{black} ✘%f %f|%k)${root}%K{black}%F{blue} > %f%k'
  case $(whoami) in
    'root')
      export PROMPT="%F{red}#%f " ;;
    *)
      export PROMPT="%F{green}$%f " ;;
  esac
else
  case $(whoami) in
    'root')
      export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{red}#%f " ;;
    *)
      export PROMPT="%F{green}%n%f%F{magenta}@%f%F{blue}%m%f%F{magenta}:%f%F{cyan}%~%f
%F{green}$%f " ;;
  esac
  export RPROMPT="${git_info}"
  #PROMPT=$'%(?,,%F{red}%K{black} ✘%f %f|%k)${root}${dir}%K{black}%F{blue}> %f%k'
  #RPROMPT=$'${git_info}'
fi

export PROMPT2="%F{blue}> %f"
export SPROMPT="zsh: correct? %F{red}%R%f -> %F{green}%r%f [y/n]: "
## }}}



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

# NVM node version manager
#if [ -e "$HOME/.nvm" ]; then
#  export NVM_DIR="$HOME/.nvm"
#  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
#
#  # place this after nvm initialization!
#  autoload -U add-zsh-hook
#  function load-nvmrc() {
#    local node_version="$(nvm version)"
#    local nvmrc_path="$(nvm_find_nvmrc)"
#
#    if [ -n "$nvmrc_path" ]; then
#      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#
#      if [ "$nvmrc_node_version" = "N/A" ]; then
#        nvm install
#      elif [ "$nvmrc_node_version" != "$node_version" ]; then
#        nvm use
#      fi
#    elif [ "$node_version" != "$(nvm version default)" ]; then
#      echo "Reverting to nvm default version"
#      nvm use default
#    fi
#  }
#  add-zsh-hook chpwd load-nvmrc
#  load-nvmrc
#fi

## Set up Homebrew
if [ $OSTYPE = linux-gnu -o $OSTYPE = linux ]; then
  if [ -e "HOMEBREW_ROOT=$HOME/.linuxbrew" ]; then
    export HOMEBREW_ROOT=$HOME/.linuxbrew
    export PATH=$HOMEBREW_ROOT/sbin:$PATH
    export PATH=$HOMEBREW_ROOT/bin:$PATH
    export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
    export INFOPATH=$HOMEBREW_ROOT/share/info:$INFOPATH
    export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib64:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib:$LD_LIBRARY_PATH
    export XDG_DATA_DIRS=$HOME/.linuxbrew/share:$XDG_DATA_DIRS
    # Optional
    export HOMEBREW_NO_ENV_FILTERING=1
    export HOMEBREW_DEVELOPER=1
    export HOMEBREW_CURL_PATH=$HOME/.local/usr/bin/curl
    export HOMEBREW_GIT_PATH=$HOME/.local/usr/bin/git

    eval "$($HOMEBREW_ROOT/bin/brew shellenv)"
  fi
fi

## Set up anyenv.
#if [ -e "$HOME/.anyenv" ]; then
#  if command -v anyenv 1>/dev/null 2>&1; then
#
#    if [ -e "$ANYENV_ROOT/envs/pyenv" ]; then
#      export PYENV_ROOT="$ANYENV_ROOT/envs/pyenv"
#      export PATH="$PYENV_ROOT/bin:$PATH"
#      eval "$(pyenv init --path)"
#      if command -v pyenv 1>/dev/null 2>&1; then
#        eval "$(pyenv init -)"
#      fi
#    fi
#
#    eval "$(anyenv init -)"
#    for D in `ls $ANYENV_ROOT/envs`; do
#      export PATH="$ANYENV_ROOT/envs/$D/shims:$PATH"
#    done
#  fi
#fi

## Set up rust.
if [ -e "$HOME/.cargo" ]; then
  export CARGO_ROOT="$HOME/.cargo"
  export PATH="$CARGO_ROOT/bin:$PATH"
fi

## Set up golang.
if [ -e "$HOME/.golang" ]; then
  export GOPATH="$HOME/.golang"
  export PATH="$GOPATH/bin:$PATH"
fi

## Install tmux plugin manager.
if [ ! -d $HOME/.cache/tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.cache/tmux/plugins/tpm
fi

# Read local file
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

# Install plugins.
if [ -f $ZDOTDIR/zplug.zsh ]; then
  source $ZDOTDIR/zplug.zsh
fi

# Compile .zshrc only once at first.
if [ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]; then
  zcompile $ZDOTDIR/.zshrc
fi

