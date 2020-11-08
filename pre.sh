#!/usr/bin/env bash

set -e

# https://mirrors.tuna.tsinghua.edu.cn/help/nix/

# 1. install nix
# echo ">>> install nix ..."
# curl -L https://nixos.org/nix/install | sh
# mirror
# sh <(curl https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install)

# 2. set Nixpkgs channel mirror
echo ">>> set Nixpkgs channel mirror ..."
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
nix-channel --update

# 3. set cachix mirror
echo ">>> set cachix mirror ..."
mkdir -p ~/.config/nix
echo "substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/" >> ~/.config/nix/nix.conf

# 4. install cachix
echo ">>> install cachix ..."
nix-env -iA cachix -f https://cachix.org/api/v1/install

# 5. set cache
echo ">>> set cache ..."
cachix use arcueid

# 6. install niv
echo ">>> install niv ..."
nix-env -iA nixpkgs.niv

# 7. install home-manager
echo ">>> install home-manager ..."
# nix-env -iA home-manager -f https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz

# or
# recommend
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

echo ">>> finished! run: `home-manager switch -f home.nix --show-trace` to install pkgs"
