#!/usr/bin/env bash

set -e

style_normal='\033[0m'
style_red='\033[31m'

echo_red() {
    echo -e "${style_red}$@${style_normal}"
}

install_nix() {
    echo_red ">>> install nix ..."
    curl -L https://nixos.org/nix/install | sh
}

install_cachix() {
    echo_red ">>> install cachix ..."
    nix-env -iA cachix -f https://cachix.org/api/v1/install
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
    install_cachix
    install_home_manager
}

HELP="support command: \n \
    install_nix \n \
    install_cachix \n \
    install_home_manager \n \
    \n \
    set_all for exec above all"

case "$1" in
    "install_nix")
        install_nix
        ;;
    "install_cachix")
        install_cachix
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
