#!/usr/bin/env bash

lock_file="$PWD/default.nix"

install="nix-env -iA -f $lock_file pkgs"

# macOS bsd tools to gnu.
case "$(uname -s)" in
    Darwin)
        eval $install.coreutils
        eval $install.gnugrep
        eval $install.gnutar
        eval $install.findutils
        eval $install.gnused
        ;;
    Linux)
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*)
        ;;
    *)
        echo 'Only Support Linux and OSX'
        ;;
esac
