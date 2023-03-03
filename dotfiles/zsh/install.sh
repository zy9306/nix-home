#!/usr/bin/env bash

# should run in bash, run with sh will print `-e` in echo func

set -e

source .shutils

CONFIG_PATH=$PWD

export ZPLUG_HOME=$HOME/.zplug

if [ ! -f /usr/bin/gawk ]; then
  echo_red "gawk is not installed, Unknown error will occur with zplug, try apt-get install gawk or brew install coreutils in macos"
fi

if [[ $1 == --offline ]]; then
  rm -rf $ZPLUG_HOME
  cp $CONFIG_PATH/.zplug.tar.gz $HOME
  tar zxvf .zplug.tar.gz -C $HOME
  rm -f $HOME/.zplug.tar.gz
elif [[ $1 == --online ]]; then
  rm -rf $ZPLUG_HOME
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
else
  echo_cyan "pass --offline or --online"
  exit 0
fi

cd

rm -f .zshenv .zshrc .app .env .shutils .starship
ln -s ${CONFIG_PATH}/.zshenv .zshenv
ln -s ${CONFIG_PATH}/.zshrc .zshrc
ln -s ${CONFIG_PATH}/.env .env
ln -s ${CONFIG_PATH}/.app .app
ln -s ${CONFIG_PATH}/.shutils .shutils
ln -s ${CONFIG_PATH}/.starship .starship
chsh -s $(which zsh)

echo_red "Done!"
