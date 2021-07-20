#!/usr/bin/env bash

lock_file="$PWD/default.nix"

locked_nix_install="nix-env -iA -f $lock_file"

eval $locked_nix_install nixpkgs.nixfmt

# shell
eval $locked_nix_install nixpkgs.starship

# search
eval $locked_nix_install nixpkgs.ripgrep
eval $locked_nix_install nixpkgs.fd
eval $locked_nix_install nixpkgs.fzf

# utils
eval $locked_nix_install nixpkgs.unzip
eval $locked_nix_install nixpkgs.htop
eval $locked_nix_install nixpkgs.xclip
eval $locked_nix_install nixpkgs.gawk
eval $locked_nix_install nixpkgs.universal-ctags
eval $locked_nix_install nixpkgs.global
eval $locked_nix_install nixpkgs.cloc
eval $locked_nix_install nixpkgs.pandoc
eval $locked_nix_install nixpkgs.bat
eval $locked_nix_install nixpkgs.exa
eval $locked_nix_install nixpkgs.navi
eval $locked_nix_install nixpkgs.tealdeer

# git
eval $locked_nix_install nixpkgs.git
eval $locked_nix_install nixpkgs.git-lfs
eval $locked_nix_install nixpkgs.gitAndTools.delta
eval $locked_nix_install nixpkgs.bfg-repo-cleaner
eval $locked_nix_install nixpkgs.gitAndTools.git-filter-repo
eval $locked_nix_install nixpkgs.gitAndTools.pre-commit

# network
eval $locked_nix_install nixpkgs.curl
eval $locked_nix_install nixpkgs.wget
eval $locked_nix_install nixpkgs.aria2

# k8s tool
eval $locked_nix_install nixpkgs.stern


## go
## nixpkgs.go_1_14
## nixpkgs.go_1_15
## go-1.16
eval $locked_nix_install nixpkgs.go


# macOS bsd tools to gnu.
case "$(uname -s)" in
    Darwin)
        eval $locked_nix_install nixpkgs.coreutils-full
        eval $locked_nix_install nixpkgs.gnugrep
        eval $locked_nix_install nixpkgs.gnutar
        eval $locked_nix_install nixpkgs.findutils
        eval $locked_nix_install nixpkgs.gnused
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
