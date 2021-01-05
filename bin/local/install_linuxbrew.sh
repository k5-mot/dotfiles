sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
export HOMEBREW_ROOT=$HOME/.linuxbrew
export PATH=$HOMEBREW_ROOT/bin:$PATH
export PATH=$HOMEBREW_ROOT/sbin:$PATH
export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
export INFOPATH=$HOMEBREW_ROOT/share/info:$INFOPATH
export LD_LIBRARY_PATH=$HOMEBREW_ROOT/lib:$LD_LIBRARY_PATH
brew doctor
