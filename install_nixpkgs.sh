#!/usr/bin/env bash

nix-env -i -f nixpkgs.nix

./install_locked.sh
