#!/usr/bin/env bash

# install nix
curl -L https://nixos.org/nix/install | sh

# install cachix
nix-env -iA cachix -f https://cachix.org/api/v1/install

# set cache
cachix use arcueid

# install niv
nix-env -iA nixpkgs.niv

# install home-manager
# nix-env -iA home-manager -f https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz

# or
# recommend
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# use home-manager
# home-manager switch -f home.nix --show-trace
