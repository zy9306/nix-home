#!/usr/bin/env bash

mkdir -p ~/.ssh/sockets

FILE="$HOME/.ssh/config"

rm -rf $FILE

ln -s $PWD/config $FILE
