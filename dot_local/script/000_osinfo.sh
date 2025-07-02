#!/usr/bin/env bash

export OS_NAME=$(cat /etc/*-release | grep "PRETTY_NAME=" | sed 's/^.*"\(.*\)"$/\1/')
printf "OS_NAME: $OS_NAME"
