
## Install required packages by apt.
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean

## Change package server to mirror servers
#sudo sed -i.bak -r 's!(deb|deb-src) \S+!\1 mirror://mirrors.ubuntu.com/mirrors.txt!' /etc/apt/

## Install packages
sudo apt install -y build-essential
#sudo apt install -y libffi-dev
#sudo apt install -y libssl-dev
#sudo apt install -y zlib1g-dev
#sudo apt install -y liblzma-dev
#sudo apt install -y libbz2-dev
sudo apt install -y libreadline-dev
sudo apt install -y libsqlite3-dev
sudo apt install -y git
sudo apt install -y cmake
sudo apt install -y automake
sudo apt install -y autoconf
sudo apt install -y pkg-config
sudo apt install -y bison
#sudo apt install -y autotools-dev
sudo apt install -y libevent-dev
sudo apt install -y libncurses-dev
sudo apt install -y make
sudo apt install -y gcc
sudo apt install -y g++
#sudo apt install -y ninja-build
#sudo apt install -y gettext
#sudo apt install -y libtool
sudo apt install -y libtool-bin
sudo apt install -y unzip
#sudo apt install -y build-dep
#sudo apt install -y xorg-dev
#sudo apt install -y libgtk2.0-dev
#sudo apt install -y libssl-dev
#sudo apt install -y libreadline-dev
#sudo apt install -y zlib1g-dev
#sudo apt install -y libbz2-dev
#sudo apt install -y libsqlite3-dev
#sudo apt install -y libncurses5-dev
#sudo apt install -y libncursesw5-dev
#sudo apt install -y libkrb5-dev
#sudo apt install -y npm
sudo apt install -y vim
sudo apt install -y emacs
sudo apt install -y neovim
sudo apt install -y zsh
sudo apt install -y tmux
sudo apt install -y curl
sudo apt install -y wget
#sudo apt install -y llvm
#sudo apt install -y sqlite3
sudo apt install -y python
sudo apt install -y python-dev
sudo apt install -y python3
sudo apt install -y python3-dev
#sudo apt install -y python-tk
#sudo apt install -y python3-tk
#sudo apt install -y tk-dev
#sudo apt install -y aria2
#sudo apt install -y octave
#sudo apt install -y autoconf
#sudo apt install -y bison
#sudo apt install -y libssl-dev
#sudo apt install -y libyaml-dev
#sudo apt install -y libreadline6-dev
#sudo apt install -y zlib1g-dev
#sudo apt install -y libncurses5-dev
#sudo apt install -y libffi-dev
#sudo apt install -y libgdbm6
#sudo apt install -y libgdbm-dev
#sudo apt install -y libdb-dev
#sudo apt install -y clang-tools
#sudo apt install -y clangd
#sudo apt install -y ccls
#sudo npm install -g n
#sudo n stable
#sudo apt install -y ccache
