#!/usr/bin/env bash

rm -rf $HOME/.config/yapf && mkdir -p $HOME/.config/yapf

ln -s $PWD/style $HOME/.config/yapf/style
