#!/usr/bin/env bash

set -e

nix-env -iA nixpkgs.nixfmt

# shell
nix-env -iA nixpkgs.starship

# search
nix-env -iA \
        nixpkgs.ripgrep \
        nixpkgs.fd \
        nixpkgs.fzf \
        -f ./default.nix 

# utils
nix-env -iA \
        nixpkgs.unzip \
        nixpkgs.htop \
        nixpkgs.xclip \
        nixpkgs.gawk \
        nixpkgs.coreutils-full \
        nixpkgs.universal-ctags \
        nixpkgs.global \
        nixpkgs.cloc \
        nixpkgs.pandoc \
        nixpkgs.bat \
        nixpkgs.exa \
        nixpkgs.navi \
        nixpkgs.tealdeer \
        -f ./default.nix 

# git
nix-env -iA \
        nixpkgs.git \
        nixpkgs.git-lfs \
        nixpkgs.gitAndTools.delta \
        nixpkgs.bfg-repo-cleaner \
        nixpkgs.gitAndTools.git-filter-repo \
        nixpkgs.gitAndTools.pre-commit \
        -f ./default.nix 

# network
nix-env -iA \
        nixpkgs.curl\
        nixpkgs.wget\
        nixpkgs.aria2 \
        -f ./default.nix 

# language
nix-env -iA nixpkgs.nodejs-14_x -f ./default.nix 
# curl https://bootstrap.pypa.io/get-pip.py | python3.7
nix-env -iA nixpkgs.python37Full -f ./default.nix 
# nixpkgs.go_1_14
# 1.15.x
nix-env -iA nixpkgs.go -f ./default.nix 

nix-env -iA extra.q -f ./default.nix 
