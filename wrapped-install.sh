#!/usr/bin/env bash

NixWrappedInstall() {
    NIX_PKG=$1
    NIX_INSTALL_FORCE=$2
    NIX_INSTALL_CMD="nix-env -iA nixpkgs.$NIX_PKG"
    NIX_INSTALL_FLAG=false

    if [ -z $1 ];then
        echo "please pass a pkg to install."
        exit 0
    fi

    # nix-env redirect all info to stderr, so redirect stderr to stdout by 2>&1
    NIX_PKG_INSTALLED=$($NIX_INSTALL_CMD --dry-run 2>&1 | grep "replacing")

    if [ -n "$NIX_PKG_INSTALLED" ];then
        if [[ $2 == "-f" ]];then
            NIX_INSTALL_FLAG=true
        fi
    else
        NIX_INSTALL_FLAG=true
    fi

    if [[ $NIX_INSTALL_FLAG == "true" ]];then
       $($NIX_INSTALL_CMD 2>&1)
    else
        echo "$1 has installed, pass -f to replacing."
    fi
}
