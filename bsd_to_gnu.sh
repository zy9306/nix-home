#!/usr/bin/env bash

install="nix-env -iA pkgs"

# macOS bsd tools to gnu.
case "$(uname -s)" in
Darwin)
  eval $install.coreutils
  eval $install.gnugrep
  eval $install.gnutar
  eval $install.findutils
  eval $install.gnused
  ;;
Linux) ;;

CYGWIN* | MINGW32* | MSYS* | MINGW*) ;;

*)
  echo 'Only Support Linux and OSX'
  ;;
esac
