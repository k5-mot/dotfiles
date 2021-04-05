
## Downloal binary
mkdir -p $HOME/.local/src
mkdir -p $HOME/.local/src/texlive
cd $HOME/.local/src/texlive
wget https://ftp.kddilabs.jp/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -zxvf install-tl-unx.tar.gz
cd install-tl-*

## Install
sudo mkdir -p /usr/local/texlive
sudo chown -R $(whoami):$(whoami) /usr/local/
sudo bash ./install-tl
