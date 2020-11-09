#!/usr/bin/env bash

set -e

style_red='\033[31m'
style_normal='\033[0m'

echo_red() {
    echo -e "${style_red}$@${style_normal}"
}


pwd=$PWD
archive=".tmux.tar.gz"

mkdir -p $HOME/.tmux/plugins

# 如果想全新安装 先执行: rm -rf ~/.tmux

if [ ! -d $HOME/.tmux/plugins/tpm ];then

    if [[ $1 == --offline ]];then
        cp $pwd/$archive $HOME
        tar zxvf $archive -C $HOME
        rm -f $HOME/$archive
    elif [ -z $1 ];then
        git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    else
        echo "tip: pass --offline for offline install or none for normal install"
        exit 0
    fi

fi


echo_red "make sure xclip or xsel is installed"

cd

rm -f .tmux.conf
ln -s $pwd/.tmux.conf .tmux.conf
