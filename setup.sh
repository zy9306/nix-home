#!/usr/bin/env bash

set -e

STYLE_NORMAL='\033[0m'
STYLE_RED='\033[31m'

echo_red() {
    echo -e "${STYLE_RED}$@${STYLE_NORMAL}"
}

install_nix() {
    echo_red ">>> install nix ..."
    curl -L https://nixos.org/nix/install | sh
}

update_nix_channel() {
    echo_red ">>> update nix channel ..."
    nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
}

install_cachix() {
    echo_red ">>> install cachix ..."
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
esac
