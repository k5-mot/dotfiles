#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# read up colors
autoload -Uz colors
colors

# dircolors
if [[ -f ~/.dircolors && -x `which dircolors` ]]; then
  eval `dircolors -b ~/.dircolors`
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

# Set up aliases
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias cp='nocorrect cp -i'       # no spelling correction on cp
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
alias lla='ls -al'
alias x=exit
alias latexmk='latexmk -outdir=out'
alias grep='grep --color=auto'

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
#for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

manpath=(/opt/share/man /usr/share/man)
export MANPATH

# Hosts to use for completion (see later zstyle)
hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Set prompts
if [ $TERM = screen ]; then
  promptname=$(print "\ek%m\e\\")$USERNAME
else
  promptname=$USERNAME
fi
#PROMPT="%U%B$promptname%b [ %m : %~ ]%u
# "
PROMPT="
%F{green}$promptname%f@%F{blue}%M%f:%F{cyan}%~%f
$ "


# Some environment variables
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

MAILCHECK=0
HISTSIZE=200
DIRSTACKSIZE=20

# Watch for my friends
# watch=( $(<~/.friends) )       # watch for people in .friends file
# watch=(notme)                   # watch for everybody but me
# LOGCHECK=300                    # check every 5 min for login/logout activity
# WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt   ignoreeof
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# bindkey -v               # vi key bindings

bindkey -e                 # emacs key bindings
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

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
  '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# enviroment variables
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export JSERVER="localhost"

# set up tetris
autoload -Uz tetris
zle -N tetris
bindkey '...' tetris

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

## Set up anyenv.
if [ $OSTYPE = linux-gnu -o $OSTYPE = linux ]; then

  ## Set up pyenv
  if [ -e "$HOME/.pyenv" ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi
  fi

  ## Set up rbenv
  if [ -e "$HOME/.rbenv" ]; then
    export RBENV_ROOT=$HOME/.rbenv
    export PATH=$RBENV_ROOT/bin:$PATH
    if command -v rbenv 1>/dev/null 2>&1; then
      eval "$(rbenv init -)"
    fi
  fi

  ## Set up nodenv
  if [ -e "$HOME/.nodenv" ]; then
    export NODENV_ROOT=$HOME/.nodenv
    export PATH=$NODENV_ROOT/bin:$PATH
    if command -v nodenv 1>/dev/null 2>&1; then
      eval "$(nodenv init -)"
    fi
  fi
fi

# Setup VcXsrv for WSL
if [ `uname` = 'Linux' ]; then
  if [[ `uname -r` = *microsoft* ]]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  fi
fi

# read local file
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

# read config file for Antigen.
if [ -f ~/.zshrc_antigen ]; then
  source ~/.zshrc_antigen
fi
