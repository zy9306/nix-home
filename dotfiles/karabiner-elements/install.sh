#!/usr/bin/env bash

KARABINER_DIR=$HOME/.config/karabiner
KARABINER_CONFIG_DIR=$KARABINER_DIR/assets/complex_modifications

mkdir -p $KARABINER_CONFIG_DIR

rm -f $KARABINER_CONFIG_DIR/*

ln -s $PWD/command-fb.json $KARABINER_CONFIG_DIR/command-fb.json
