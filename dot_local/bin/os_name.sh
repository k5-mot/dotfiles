#!/usr/bin/env zsh

distro_name=$(cat /etc/*-release | grep '^NAME=[^ ]*' | sed 's/NAME=//g' | sed 's/"//g')
distro_id=$(cat /etc/*-release | grep '^ID=[^ ]*' | sed 's/ID=//g' | sed 's/"//g')
if [[ $distro_id = "amzn" ]]; then
  ## Amazon Linux
  distro_icon="\uf270"
elif [[ $distro_id = "arch" ]]; then
  ## Arch Linux
  distro_icon="\uf303"
elif [[ $distro_id = "centos" ]]; then
  ## CentOS Linux
  distro_icon="\uf304"
  distro_name="CentOS"
elif [[ $distro_id = "debian" ]]; then
  ## Debian
  distro_icon="\uf306"
elif [[ $distro_id = "fedora" ]]; then
  ## Fedora
  distro_icon="\uf30b"
elif [[ $distro_id = "opensuse" ]]; then
  ## openSUSE
  distro_icon="\uf314"
elif [[ $distro_id = "rhel" ]]; then
  ## Red Hat Enterprise Linux
  distro_icon="\uf316"
elif [[ $distro_id = "slackware" ]]; then
  ## Slackware
  distro_icon="\uf319"
elif [[ $distro_id = "sles" ]]; then
  ## SUSE Linux Enterprise Server
  distro_icon="\uf314"
elif [[ $distro_id = "ubuntu" ]]; then
  ## Ubuntu
  distro_icon="\uf31b"
elif [[ $distro_id = "mageia" ]]; then
  ## Mageia
  distro_icon="\uf310"
elif [[ $distro_id = "raspbian" ]]; then
  ## Raspbian
  distro_icon="\uf315"
elif [[ $distro_id = "alpine" ]]; then
  ## Alpine Linux
  distro_icon="\uf300"
elif [[ $distro_id = "elementary" ]]; then
  ## elementary os
  distro_icon="\uf309"
elif [[ $distro_id = "gentoo" ]]; then
  ## Gentoo Linux
  distro_icon="\uf30d"
elif [[ $distro_id = "linuxmint" ]]; then
  ## Linux Mint
  distro_icon="\uf30e"
elif [[ $distro_id = "manjaro" ]]; then
  ## Manjaro Linux
  distro_icon="\uf312"
elif [[ $distro_id = "kali" ]]; then
  ## Kali Linux
  distro_icon="\uf17c"
else
  ## Other
  distro_icon="\uf17c"
fi

echo "${distro_name}"

