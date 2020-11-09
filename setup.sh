#!/usr/bin/env bash

set -e

# 缓存可选,清华的镜像速度也不快
# https://mirrors.tuna.tsinghua.edu.cn/help/nix/

install_nix() {
    echo ">>> install nix ..."
    curl -L https://nixos.org/nix/install | sh
}

set_channel() {
    echo ">>> set Nixpkgs channel ..."
    nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs-mirror
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
    nix-channel --update
}

set_cachix_mirror() {
    echo ">>> set cachix mirror ..."
    echo "echo substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/ >> ~/.config/nix/nix.conf"
}

install_cachix() {
    echo ">>> install cachix ..."
    nix-env -iA cachix -f https://cachix.org/api/v1/install
}

set_arcueid_cache() {
    echo ">>> set cache ..."
    cachix use arcueid
}

install_niv() {
    echo ">>> install niv ..."
    nix-env -iA nixpkgs.niv
}

install_home_manager() {
    echo ">>> install home-manager ..."
    nix-shell '<home-manager>' -A install
}

set_all() {
    install_nix
    set_channel
    set_cachix_mirror
    install_cachix
    set_arcueid_cache
    install_niv
    install_home_manager
}

HELP="support command: \n \
    install_nix \n \
    set_channel \n \
    set_cachix_mirror \n \
    install_cachix \n \
    set_arcueid_cache \n \
    install_niv \n \
    install_home_manager \n \
    \n \
    set_all for exec above all"

case "$1" in
    "install_nix")
        install_nix
        ;;
    "set_channel")
        set_channel
        ;;
    "set_cachix_mirror")
        set_cachix_mirror
        ;;
    "install_cachix")
        install_cachix
        ;;
    "set_arcueid_cache")
        set_arcueid_cache
        ;;
    "install_niv")
        install_niv
        ;;
    "install_home_manager")
        install_home_manager
        ;;
    "set_all")
        set_all
        ;;
    *)
        echo -e $HELP
esac
