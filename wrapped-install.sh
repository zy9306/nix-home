#!/usr/bin/env bash

nix_wrapped_install() {
    nix_pkg=$1
    nix_install_force=$2
    nix_install_cmd="nix-env -iA nixpkgs.$nix_pkg"
    nix_install_flag=false

    if [ -z $1 ];then
        echo "please pass a pkg to install."
        return
    fi

    # nix-env redirect all info to stderr, so redirect stderr to stdout by 2>&1
    nix_pkg_installed=$($nix_install_cmd --dry-run 2>&1 | grep "replacing")

    if [ -n "$nix_pkg_installed" ];then
        if [[ $2 == "-f" ]];then
            nix_install_flag=true
        fi
    else
        nix_install_flag=true
    fi

    if [[ $nix_install_flag == "true" ]];then
       $($nix_install_cmd)
    else
        echo "$1 has installed, pass -f to replacing."
    fi
}
