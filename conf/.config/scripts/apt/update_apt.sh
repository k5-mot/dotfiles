#!/bin/sh

## Update all packages for apt.
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean

