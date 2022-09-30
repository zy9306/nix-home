# -*- mode: sh -*-

# config LD_LIBRARY_PATH
if [ -d /usr/local/lib ]; then
  APPEND_LD_LIBRARY_PATH="/usr/local/lib:/usr/local/lib64"
  if [[ $LD_LIBRARY_PATH != *"$APPEND_LD_LIBRARY_PATH"* ]]; then
    if [ ! $LD_LIBRARY_PATH ]; then
      export LD_LIBRARY_PATH=$APPEND_LD_LIBRARY_PATH
    else
      export LD_LIBRARY_PATH=$APPEND_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
    fi
  fi
fi

# init nix env
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

if [[ $(uname -s) == "Linux" ]]; then
  SYS_PATH="$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/bin"
  export PATH="$SYS_PATH:${PATH}"
fi

source $HOME/.shutils
source $HOME/.env
