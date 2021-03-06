
mkdir -p $HOME/.local
mkdir -p $HOME/.local/src
#mkdir -p $HOME/.local/src/llvm
#cd $HOME/.local/src/llvm
cd $HOME/.local/src

if [ -d $HOME/.local/src/llvm-project ]; then
  rm -rf $HOME/.local/src/llvm-project
fi
git clone https://github.com/llvm/llvm-project.git

#https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.1/clang+llvm-11.0.1-x86_64-linux-sles12.4.tar.xz


#wget https://github.com/llvm/llvm-project/archive/llvm-10.0.0.tar.gz
#tar -zxvf llvmorg-10.0.0.tar.gz
#cd llvm-project-llvmorg-10.0.0
cd llvm-project/
mkdir build
cd build/
cmake ../llvm -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME/.local/usr
make -j 3
make install
