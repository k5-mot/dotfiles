#!/usr/bin/env zsh

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
alias lla='ls -la'
alias x=exit
#alias latexmk='latexmk -outdir=out'
alias grep='grep --color=auto'

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

# Check porg
alias porg-check='porg --logdir=$HOME/.local/var/log/porg'

# Shell functions
function setenv()
{
  typeset -x "${1}${1:+=}${(@)argv[2,$#]}"
}  # csh compatibility

alias echopath="echo $PATH | sed -e 's/:/\n/g'"
alias echolibpath="echo $LD_LIBRARY_PATH | sed -e 's/:/\n/g'"
alias echolibpath2="echo $LIBRARY_PATH | sed -e 's/:/\n/g'"

function freload() {
  while (( $# )); do;
    unfunction $1;
    autoload -U $1;
    shift;
  done
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

function check_path() {
  echo $PATH | sed -e "s/:/\n/g"
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

# Setup VcXsrv for WSL
if [ "$(uname 2> /dev/null)" = Linux ]; then
  if [[ "$(uname -r 2> /dev/null)" = *microsoft* ]]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  fi
fi
