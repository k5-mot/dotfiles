#!/usr/bin/env bash

export OS_NAME=$(cat /etc/*-release | grep "PRETTY_NAME=" | sed 's/^.*"\(.*\)"$/\1/')
echo "OS_NAME: $OS_NAME"
