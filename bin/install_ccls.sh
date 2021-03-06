mkdir -p $HOME/.local
mkdir -p $HOME/.local/src
cd $HOME/.local/src

if [ -d $HOME/.local/src/ccls ]; then
  rm -rf $HOME/.local/src/ccls
fi
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls

# Download "Pre-Built Binaries" from https://releases.llvm.org/download.html
# and unpack to /path/to/clang+llvm-xxx.
# Do not unpack to a temporary directory, as the clang resource directory is hard-coded
# into ccls at compile time!
# See https://github.com/MaskRay/ccls/wiki/FAQ#verify-the-clang-resource-directory-is-correct
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$HOME/.local/usr
cmake --build Release
