#!/usr/bin/env bash

./nix_wrapped_install nixfmt

# shell
./nix_wrapped_install starship

# search
./nix_wrapped_install ripgrep
./nix_wrapped_install fd
./nix_wrapped_install fzf

# utils
./nix_wrapped_install unzip
./nix_wrapped_install htop
./nix_wrapped_install xclip
./nix_wrapped_install gawk
./nix_wrapped_install universal-ctags
./nix_wrapped_install global
./nix_wrapped_install cloc
./nix_wrapped_install pandoc
./nix_wrapped_install bat
./nix_wrapped_install exa
./nix_wrapped_install navi
./nix_wrapped_install tealdeer

# git
./nix_wrapped_install git
./nix_wrapped_install git-lfs
./nix_wrapped_install gitAndTools.delta
./nix_wrapped_install bfg-repo-cleaner
./nix_wrapped_install gitAndTools.git-filter-repo
./nix_wrapped_install gitAndTools.pre-commit

# network
./nix_wrapped_install curl
./nix_wrapped_install wget
./nix_wrapped_install aria2 

# language
## node
./nix_wrapped_install nodejs-14_x

## python
## curl https://bootstrap.pypa.io/get-pip.py | python3.7
### virtualenv
### python3.7 -m pip install virtualenv virtualenv-clone virtualenvwrapper
### mkvirtualenv venv37 --python=python3.7
### nix-shell -p python39
### mkvirtualenv venv39 --python=python3.9
./nix_wrapped_install python37Full

## go
## nixpkgs.go_1_14
## nixpkgs.go_1_15
## go-1.16
./nix_wrapped_install go

# extra
nix-env -iA extra.i extra.s -f ./default.nix


# macOS bsd tools to gnu.
case "$(uname -s)" in
    Darwin)
        ./nix_wrapped_install coreutils-full
        ./nix_wrapped_install gnugrep
        ./nix_wrapped_install gnutar
        ./nix_wrapped_install findutils
        ./nix_wrapped_install gnused
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
