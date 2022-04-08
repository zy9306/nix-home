#!/usr/bin/env bash

set -e

install_nix() {
  echo ">>> install nix ..."
  curl -L https://nixos.org/nix/install | sh
}

update_nix_channel() {
  echo ">>> update nix channel ..."
  nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
  # from ./nix/sources.json
  nix-channel --add https://github.com/NixOS/nixpkgs/archive/30d3d79b7d3607d56546dd2a6b49e156ba0ec634.tar.gz pkgs
  nix-channel --update
}

install_cachix() {
  echo ">>> install cachix ..."
  nix-env -iA cachix -f https://cachix.org/api/v1/install
  cachix use arcueid
}

set_all() {
  install_nix
  update_nix_channel
  install_cachix
}

# cachix mirror
# ~/.config/nix/nix.conf
# make tsinghua mirror at the first.
# substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/

HELP="support command: \n \
    install_nix \n \
    update_nix_channel \n \
    install_cachix \n \
    \n \
    set_all for exec above all"

case "$1" in
"install_nix")
  install_nix
  ;;
"update_nix_channel")
  update_nix_channel
  ;;
"install_cachix")
  install_cachix
  ;;
"set_all")
  set_all
  ;;
*)
  echo -e $HELP
  ;;
esac
