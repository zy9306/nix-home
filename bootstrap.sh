#!/usr/bin/env bash

source ./wrapped-install.sh

NixWrappedInstall nixfmt

# shell
NixWrappedInstall starship

# search
NixWrappedInstall ripgrep
NixWrappedInstall fd
NixWrappedInstall fzf

# utils
NixWrappedInstall unzip
NixWrappedInstall htop
NixWrappedInstall xclip
NixWrappedInstall gawk
NixWrappedInstall coreutils-full
# NixWrappedInstall universal-ctags
NixWrappedInstall global
NixWrappedInstall cloc
NixWrappedInstall pandoc
NixWrappedInstall bat
NixWrappedInstall exa
NixWrappedInstall navi
NixWrappedInstall tealdeer

# git
NixWrappedInstall git
NixWrappedInstall git-lfs
NixWrappedInstall gitAndTools.delta
NixWrappedInstall bfg-repo-cleaner
NixWrappedInstall gitAndTools.git-filter-repo
NixWrappedInstall gitAndTools.pre-commit

# network
NixWrappedInstall curl
NixWrappedInstall wget
NixWrappedInstall aria2 

# language
## node
NixWrappedInstall nodejs-14_x

## python
## curl https://bootstrap.pypa.io/get-pip.py | python3.7
NixWrappedInstall python37Full
NixWrappedInstall python38Full

## go
## nixpkgs.go_1_14
## nixpkgs.go_1_15
## go-1.16
NixWrappedInstall go

# extra
nix-env -iA extra.i extra.s -f ./default.nix
