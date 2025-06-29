#!/bin/sh

export OS_NAME=$(cat /etc/*-release | grep "PRETTY_NAME=" | sed 's/^.*"\(.*\)"$/\1/')
printf "\e[30;42;1m$OS_NAME\e[0m\n"
