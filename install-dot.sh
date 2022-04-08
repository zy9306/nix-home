#!/usr/bin/env bash

ROOT=$PWD

__dotfilesDir="dotfiles"
__privateDir="private"

for dir in {"alacritty","pip","yapf","proxychains-ng","prettier"}; do
  cd $ROOT && cd $__dotfilesDir/$dir && ./install.sh
done

for dir in {"navi-cheat",}; do
  cd $ROOT && cd $__privateDir/$dir && ./install.sh
done
