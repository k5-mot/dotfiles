#!/usr/bin/env bash

## Install LLVM

## Debug
set -x
cd $HOME/

## Remove installed apps
cd $HOME/.local/src/
if (type "porg" > /dev/null 2>&1); then
  porg -r llvm
fi

## Remove sources of installed apps
rm -rf $HOME/.local/src/llvm
cd $HOME/.local/src/

## Download
git clone https://github.com/llvm/llvm-project.git
cd $HOME/.local/src/llvm-project/
export LLVM_VERSION=$(git tag | sed -e 's/llvmorg-//g' | grep -e '[0-9]*\.[0-9]*\.[0-9]*' | tail -1)
#mkdir build
#cd build/

## Install
cmake -S llvm -B build -G "Unix Makefiles" \
  -DLLVM_PARALLEL_LINK_JOBS="1" \
  -DCMAKE_C_COMPILER="gcc" \
  -DCMAKE_CXX_COMPILER="g++" \
  -DCMAKE_INSTALL_PREFIX="$HOME/.local/usr" \
  -DCMAKE_BUILD_TYPE="Release" \
  -DLLVM_ENABLE_ASSERTIONS=On
  #-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;libc;libclc;libcxx;libcxxabi;libunwind;lld;lldb;openmp;parallel-libs;polly;pstl" \

cd build
make
porg -lp llvm-${LLVM_VERSION} "make install"

## Check
porg llvm
cd $HOME

