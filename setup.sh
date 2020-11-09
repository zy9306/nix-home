#!/usr/bin/env bash

set -e

style_normal='\033[0m'
style_red='\033[31m'

echo_red() {
    echo -e "${style_red}$@${style_normal}"
}

# 清华的镜像速度也不快，缓存镜像似乎不起作用
# https://mirrors.tuna.tsinghua.edu.cn/help/nix/

install_nix() {
    echo_red ">>> install nix ..."
    curl -L https://nixos.org/nix/install | sh
}

set_channel() {
    echo_red ">>> set Nixpkgs channel ..."
    # 官方 channel：https://nixos.org/channels/nixpkgs-unstable
    # 注意：一定要保留 nixpkgs 这个 channel 名称，不要命名，否则 home-manager 会无法工作
    nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
    nix-channel --update
}

set_cachix_mirror() {
    echo_red ">>> set cachix mirror ..."
    echo_red "echo substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/ >> ~/.config/nix/nix.conf"
}

install_cachix() {
    echo_red ">>> install cachix ..."
    nix-env -iA cachix -f https://cachix.org/api/v1/install
}

set_arcueid_cache() {
    echo_red ">>> set cache ..."
    cachix use arcueid
}

install_niv() {
    echo_red ">>> install niv ..."
    nix-env -iA nixpkgs.niv
}

install_home_manager() {
    echo_red ">>> install home-manager ..."
    # 注意，不要删除该 channel，不然 home-manager 会无法工作
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
    nix-channel --update
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
