#!/usr/bin/env bash

nix-env -iA nixpkgs.nixfmt

# shell
nix-env -iA nixpkgs.starship

# search
nix-env -iA nixpkgs.ripgrep
nix-env -iA nixpkgs.fd
nix-env -iA nixpkgs.fzf

# utils
nix-env -iA nixpkgs.unzip
nix-env -iA nixpkgs.htop
nix-env -iA nixpkgs.xclip
nix-env -iA nixpkgs.gawk
nix-env -iA nixpkgs.universal-ctags
nix-env -iA nixpkgs.global
nix-env -iA nixpkgs.cloc
nix-env -iA nixpkgs.pandoc
nix-env -iA nixpkgs.bat
nix-env -iA nixpkgs.exa
nix-env -iA nixpkgs.navi
nix-env -iA nixpkgs.tealdeer

# git
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.git-lfs
nix-env -iA nixpkgs.gitAndTools.delta
nix-env -iA nixpkgs.bfg-repo-cleaner
nix-env -iA nixpkgs.gitAndTools.git-filter-repo
nix-env -iA nixpkgs.gitAndTools.pre-commit

# network
nix-env -iA nixpkgs.curl
nix-env -iA nixpkgs.wget
nix-env -iA nixpkgs.aria2 

# language
## node
nix-env -iA nixpkgs.nodejs-14_x

## python
## curl https://bootstrap.pypa.io/get-pip.py | python3.7
### virtualenv
### python3.7 -m pip install virtualenv virtualenv-clone virtualenvwrapper
### mkvirtualenv venv37 --python=python3.7
### nix-shell -p python39
### mkvirtualenv venv39 --python=python3.9
nix-env -iA nixpkgs.python37Full

## go
## nixpkgs.go_1_14
## nixpkgs.go_1_15
## go-1.16
nix-env -iA nixpkgs.go

# extra
nix-env -iA extra.i extra.s -f ./default.nix


# macOS bsd tools to gnu.
case "$(uname -s)" in
    Darwin)
        nix-env -iA nixpkgs.coreutils-full
        nix-env -iA nixpkgs.gnugrep
        nix-env -iA nixpkgs.gnutar
        nix-env -iA nixpkgs.findutils
        nix-env -iA nixpkgs.gnused
        ;;
    Linux)
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*)
        echo 'Nothing Can Do.'
        ;;
    *)
        echo 'Only Support Linux and OSX'
        ;;
esac
