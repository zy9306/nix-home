# -*- mode: sh -*-

source $HOME/.shutils

if [[ $name != "nix-shell" ]]; then
  source $HOME/.env
else
  # fix ld
  export PATH=/usr/bin:$PATH
fi
