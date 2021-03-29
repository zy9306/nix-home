#!/usr/bin/env bash

# 出现 libstdc++.so.6 等找不到的情况下，运行下该脚本

LD_LIBRARY_PATH_VAR=$LD_LIBRARY_PATH

find_lib_path(){
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

# 当文件依赖于特定版本的动态库时，使用 patchelf 对其进行 patch
# https://github.com/NixOS/patchelf
# Display shared library dependencies of a binary
# ldd path/to/binary


find_lib_path

if [ $LD_LIBRARY_PATH_VAR ];then
    LD_LIBRARY_PATH_VAR="$LD_LIBRARY_PATH_VAR:$HOME/.nix-profile/lib"
else
    LD_LIBRARY_PATH_VAR="$HOME/.nix-profile/lib"
fi

echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_VAR" > $HOME/.ldconfig

unset LD_LIBRARY_PATH_VAR
