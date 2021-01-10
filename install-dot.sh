#!/usr/bin/env bash

ROOT=$PWD

for dir in {"dotfiles/alacritty","dotfiles/gtags","dotfiles/pip","dotfiles/yapf","private/navi-cheat"}
do
    cd $ROOT && cd $dir && ./install.sh
done
