#!/usr/bin/env bash

# 出现 libstdc++.so.6 等找不到的情况下，运行下该脚本

LD_LIBRARY_PATH_VAR=$LD_LIBRARY_PATH

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

LD_LIBRARY_PATH_VAR="$LD_LIBRARY_PATH_VAR:$HOME/.nix-profile/lib"

echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_VAR"

unset LD_LIBRARY_PATH_VAR

