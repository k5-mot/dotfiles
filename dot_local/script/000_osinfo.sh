<<<<<<< Updated upstream:dot_local/script/000_osinfo.sh
#!/usr/bin/env bash

export OS_NAME=$(cat /etc/*-release | grep "PRETTY_NAME=" | sed 's/^.*"\(.*\)"$/\1/')
echo "OS_NAME: $OS_NAME"
=======
#!/bin/sh

export OS_NAME=$(cat /etc/*-release | grep "PRETTY_NAME=" | sed 's/^.*"\(.*\)"$/\1/')
printf "\e[30;42;1m$OS_NAME\e[0m\n"
>>>>>>> Stashed changes:dot_local/script/0-osinfo.sh
