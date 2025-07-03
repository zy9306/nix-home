# -*- mode: sh -*-

source $HOME/.shutils
source $HOME/.zshutils

if [[ $name != "nix-shell" ]]; then
  source $HOME/.env.sh
else
  # fix ld
  export PATH=/usr/bin:$PATH
fi
