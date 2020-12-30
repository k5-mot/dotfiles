#!bin/sh

## Update packages of apt
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean
