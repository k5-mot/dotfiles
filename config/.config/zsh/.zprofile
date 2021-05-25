
## Set up anyenv.
#if [ -e "$ANYENV_ROOT" ]; then
#  if command -v anyenv 1>/dev/null 2>&1; then
#    eval "$(anyenv init -)"
#    for D in `ls $ANYENV_ROOT/envs`; do
#      export PATH="$ANYENV_ROOT/envs/$D/shims:$PATH"
#    done
#
#    if [ -e "$ANYENV_ROOT/envs/pyenv" ]; then
#      export PYENV_ROOT="$ANYENV_ROOT/envs/pyenv"
#      export PATH="$PYENV_ROOT/bin:$PATH"
#      if command -v pyenv 1>/dev/null 2>&1; then
#        eval "$(pyenv init --path)"
#      fi
#    fi
#  fi
#fi
