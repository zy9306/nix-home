#! /bin/bash

# should run in bash, run with sh will print `-e` in echo func

set -e

source .shutils

CONFIG_PATH=$PWD

if [ ! -f /usr/bin/gawk ]; then
  echo_red "gawk is not installed, Unknown error will occur with zplug, try apt-get install gawk or brew install coreutils in macos"
fi

if [ ! -d $HOME/.zplug ]; then

  if [[ $1 == --offline ]]; then
    cp $CONFIG_PATH/.zplug.tar.gz $HOME
    tar zxvf .zplug.tar.gz -C $HOME
    rm -f $HOME/.zplug.tar.gz
  elif [ -z $1 ]; then
    export ZPLUG_HOME=$HOME/.zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
  else
    echo_cyan "tip: pass --offline for offline install or none for normal install"
    exit 0
  fi

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

echo_red "设置默认shell后需要重启系统，否则tmux仍将使用bash\
（tmux可增加'set -g default-shell /bin/zsh'，但是如果没有安装zsh就会报错，\
因此最好是重启系统，而不是增加tmux配置）"
