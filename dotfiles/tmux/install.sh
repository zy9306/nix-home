#!/usr/bin/env bash

set -e

style_red='\033[31m'
style_normal='\033[0m'

echo_red() {
    echo -e "${style_red}$@${style_normal}"
}

# tpm 无法工作的原因是需要在 /usr/bin/ 下能找到 tmux ，对于 mac
# 只需要在 .tmux.conf 中添加 set-environment -g PATH
# "/usr/local/bin:/bin:/usr/bin"，如果是通过 nix 安装的 tmux，则要建立软
# 链接， 必须要有 /usr/bin/tmux 存在，mac 可能无法直接在 /usr/bin 下建立软
# 链接，可以尝试在 /usr/local/bin 下建立，因为 homebrew 会将 tmux 链接
# 到该路径，如果都无法解决，尝试 pacman 或 homebrew 等包管理安装，不用 nix
if [ -f $HOME/.nix-profile/bin/tmux ];then
    case "$(uname -s)" in
        Darwin)
            sudo ln -s $HOME/.nix-profile/bin/tmux /usr/local/bin/tmux
            ;;

        Linux)
            if [ ! -f  /usr/bin/tmux];then
                sudo ln -s $HOME/.nix-profile/bin/tmux /usr/bin/tmux
            fi
            ;;

        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            echo 'Nothing Can Do.'
            ;;
        *)
            echo 'Only Support Linux and OSX'
            ;;
    esac
fi


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

echo_red "make sure xclip or xsel is installed"

cd

rm -f .tmux.conf
ln -s $pwd/.tmux.conf .tmux.conf
