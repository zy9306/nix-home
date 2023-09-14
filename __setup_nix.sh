#!/usr/bin/env bash

set -e


update_nix_channel() {
  echo ">>> update nix channel ..."
  nix-channel --list
  nix-channel --remove nixpkgs
  nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
  nix-channel --update
}

install_cachix() {
  echo ">>> install cachix ..."
  nix-env -iA cachix -f https://cachix.org/api/v1/install
  cachix use arcueid
}

case "$1" in
"update_nix_channel")
  update_nix_channel
  ;;
"install_cachix")
  install_cachix
  ;;
*)
  echo -e "nothing to do"
  ;;
esac
