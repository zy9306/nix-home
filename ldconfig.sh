#!/usr/bin/env bash

# 出现 libstdc++.so.6 等找不到的情况下，运行下该脚本

LD_LIBRARY_PATH_VAR=$LD_LIBRARY_PATH

# 方案一：直接从 /nix/store 中找文件，加到 LD_LIBRARY_PATH 中，会将所有版本都添加
find_version(){
    for dir in $(find /nix/store -type d -wholename "*gcc*lib*/lib")
    do
        if [[ $LD_LIBRARY_PATH_VAR != *"$dir"* ]];then
            if [ ! $LD_LIBRARY_PATH_VAR ];then
                LD_LIBRARY_PATH_VAR="$dir"
            else
                LD_LIBRARY_PATH_VAR="$LD_LIBRARY_PATH_VAR:$dir"
            fi
        fi
    done
}

# 方案二：利用 nix 找出相关路径，速度较快，只添加当前版本
nix_version(){
    LD_LIBRARY_PATH_VAR=$(nix eval --raw nixpkgs.stdenv.cc.cc.lib)/lib
}

# 方案三：当文件依赖于特定版本的动态库时，使用 patchelf 对其进行 patch
# https://github.com/NixOS/patchelf
# Display shared library dependencies of a binary
# ldd path/to/binary


nix_version

if [ $LD_LIBRARY_PATH_VAR ];then
    LD_LIBRARY_PATH_VAR="$LD_LIBRARY_PATH_VAR:$HOME/.nix-profile/lib"
else
    LD_LIBRARY_PATH_VAR="$HOME/.nix-profile/lib"
fi

echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_VAR" > $HOME/.ldconfig

unset LD_LIBRARY_PATH_VAR
