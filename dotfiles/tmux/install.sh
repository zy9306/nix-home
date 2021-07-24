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

rm -rf ~/.tmux

if [[ $1 == --offline ]];then
    cp $pwd/$archive $HOME
    tar zxvf $archive -C $HOME
    rm -f $HOME/$archive
elif [[ $1 == --online ]];then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
    echo "tip: pass --offline for offline install or --online for online install"
    exit 0
fi

echo_red "make sure xclip(for X) and xsel(must) is installed"

cd

rm -f .tmux.conf
ln -s $pwd/.tmux.conf .tmux.conf
