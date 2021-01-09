#!/usr/bin/env bash

DEST="$HOME/Nutstore/linux/quick.md"

if [ ! -f $DEST ];then
    touch $DEST
fi

TODAY_STR=$(date --rfc-3339=date)
IS_NEW_DAY=$(cat $DEST | grep "# $TODAY_STR" | wc -l)

if [ $IS_NEW_DAY = 0 ];then
    echo -e "# ${TODAY_STR}\n" >> $DEST
fi

if [ ! $# = 0 ];then
    echo -e "$@\n" >> $DEST
fi
