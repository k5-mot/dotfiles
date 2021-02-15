# porg
cd $HOME/.local/src
mkdir porg
cd porg/
wget https://sourceforge.net/projects/porg/files/porg-0.10.tar.gz
tar -xzvf porg-0.10.tar.gz
cd porg-0.10/
mkdir build
cd build/
../configure --prefix=$HOME/.local/usr --sysconfdir=$HOME/.local/etc --disable-grop
make
./porg/porg -lD make install
porg --logdir=$HOME/.local/var/log/porg porg

# gmp
cd $HOME/.local/src
mkdir gmp
cd gmp/
wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.bz2
wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.bz2.sig
tar -xvf gmp-6.2.1.tar.bz2
cd gmp-6.2.1/
mkdir build
cd build
../configure --prefix=$HOME/.local/usr --enable-cxx
make && make check
porg -lp gmp-6.2.1 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg gmp

# mpfr
cd $HOME/.local/src
mkdir mpfr
cd mpfr/
wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz
wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz.sig
tar -xzvf mpfr-4.1.0.tar.gz
cd mpfr-4.1.0/
mkdir build
cd build/
../configure --prefix=$HOME/.local/usr --with-gmp=$HOME/.local/usr
make -s -j4 && make -s check
porg -lp mpfr-4.1.0 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg mpfr

# mpc
cd $HOME/.local/src
mkdir mpc
cd mpc/
wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz.sig
tar -xzvf mpc-1.2.1.tar.gz
cd mpc-1.2.1/
mkdir build
cd build/
../configure --prefix=$HOME/.local/usr --with-gmp=$HOME/.local/usr --with-mpfr=$HOME/.local/usr
make -s -j4 && make check -s -j4
porg -lp mpc-1.2.1 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg mpc

# isl
cd $HOME/.local/src
mkdir isl
cd isl/
wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2
tar -xvf isl-0.18.tar.bz2
cd isl-0.18/
mkdir build
cd build/
../configure --prefix=$HOME/.local/usr --with-gmp-prefix=$HOME/.local/usr
make -j4 && make check
porg -lp isl-0.18 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg isl

# gcc
cd $HOME/.local/src
mkdir gcc
cd gcc/
wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-10.2.0/gcc-10.2.0.tar.gz
tar -xzvf gcc-10.2.0.tar.gz
cd gcc-10.2.0/
mkdir build
cd build
../configure --enable-languages=c,c++ --prefix=$HOME/.local/usr --disable-bootstrap --disable-multilib --with-gmp=$HOME/.local/usr --with-mpc=$HOME/.local/usr --with-mpfr=$HOME/.local/usr --with-isl=$HOME/.local/usr
unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
LD_LIBRARY_PATH=$HOME/.local/usr/lib
make -j4
porg -lp gcc-10.2.0 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg gcc

# vim
cd $HOME/.local/src
git clone https://github.com/vim/vim.git
cd vim/
cd src/

mkdir build
cd build/
../configure \
--with-features=huge \
--enable-gui=gtk2 \
--enable-cscope \
--enable-terminal \
--enable-fontset \
--enable-multibyte \
--enable-nls \
--enable-fail-if-missing \
--enable-python3interp \
--enable-pythoninterp \
--enable-rubyinterp \
--enable-luainterp \
--with-python3-command=$HOME/.anyenv/envs/pyenv/versions/3.9.1/bin/python3 \
--with-python-command=$HOME/.anyenv/envs/pyenv/versions/2.7.18/bin/python2 \
--with-ruby-command=$HOME/.anyenv/envs/rbenv/versions/3.0.0/bin/ruby \
--with-lua-prefix=$HOME/.anyenv/envs/luaenv/versions/5.4.2/ \
--prefix=$HOME/.local/usr
make
porg -lp vim-8.2 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg vim


# neovim
cd $HOME/.local/src
git clone https://github.com/neovim/neovim.git
cd neovim/
make CMAKE_BUILD_TYPE=Release
porg -lp neovim --logdir=$HOME/.local/var/log/porg make CMAKE_INSTALL_PREFIX=$HOME/.local/usr install
porg --logdir=$HOME/.local/var/log/porg nvim

# cmake
cd $HOME/.local/src
mkdir cmake
cd cmake/
wget https://cmake.org/files/v3.19/cmake-3.19.4.tar.gz
tar -zxvf cmake-3.19.4.tar.gz
cd cmake-3.19.4/
mkdir build
cd build/
../configure --prefix=$HOME/.local/usr
make
porg -lp cmake-3.19.4 --logdir=$HOME/.local/var/log/porg make install
porg --logdir=$HOME/.local/var/log/porg cmake

# qhull
cd $HOME/.local/src
git clone https://github.com/qhull/qhull.git
cd qhull/
make
export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH
make test
porg -lp qhull --logdir=$HOME/.local/var/log/porg make install PREFIX=$HOME/.local/usr
porg --logdir=$HOME/.local/var/log/porg qhull

# git
cd $HOME/.local/src
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.29.2.tar.gz
tar -xzvf git-2.29.2.tar.gz
cd git-2.29.2/
make prefix=$HOME/.local/usr all
porg -lp git-2.29.2 --logdir=$HOME/.local/var/log/porg make prefix=$HOME/.local/usr install
porg --logdir=$HOME/.local/var/log/porg git-2.29.2

## Freeglut
cd $HOME/.local/src
mkdir -p freeglut
cd freeglut/
wget --content-disposition https://sourceforge.net/projects/freeglut/files/freeglut/3.2.1/freeglut-3.2.1.tar.gz/download
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local/usr/
make
porg -lp freeglut-3.2.1 --logdir=$HOME/.local/var/log/porg make prefix=$HOME/.local/usr install
porg --logdir=$HOME/.local/var/log/porg freeglut-3.2.1

## GLM
cd $HOME/.local/src/
git clone https://github.com/g-truc/glm.git
cd glm/
cp -rf glm/ $HOME/.local/include/
#$mkdir build
#$cd build/
#$cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local/usr/ ..
#$make
#$porg -lp glm --logdir=$HOME/.local/var/log/porg make prefix=$HOME/.local/usr install
#$porg --logdir=$HOME/.local/var/log/porg glm

## GLEW
cd $HOME/.local/src/
git clone https://github.com/nigels-com/glew.git

# Octave
#cd $HOME/.local/src
#mkdir octave
#cd octave/
#wget https://ftp.jaist.ac.jp/pub/GNU/octave/octave-6.1.0.tar.gz
#wget https://ftp.jaist.ac.jp/pub/GNU/octave/octave-6.1.0.tar.gz.sig
#tar -zxvf octave-6.1.0.tar.gz
#cd octave-6.1.0/
#mkdir build
#cd build/
#../configure --prefix=$HOME/.local/usr
