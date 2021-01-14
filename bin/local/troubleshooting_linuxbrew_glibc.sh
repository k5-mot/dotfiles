#! /bin/bash

target_files="c++ cpp g++ gcc x86_64-redhat-linux-c++ x86_64-redhat-linux-g++ x86_64-redhat-linux-gcc"

gcc_version=`gcc -dumpversion | cut -d. -f1,2`

if [[ -z "$gcc_version" ]]; then
  echo "Don't get GCC version."
  exit 1
fi

if [[ -x `which brew` ]]; then
  brew_prefix_dir=`brew --prefix`
  for target_file in $target_files; do
    target_path=`which $target_file`
    link_path=${brew_prefix_dir}/bin/${target_file}-${gcc_version}
    if [[ -x $target_path && ! -e $link_path ]]; then
      ln -s -v $target_path $link_path
    fi
  done
fi
