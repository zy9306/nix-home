#!/usr/bin/env bash

DEST="$HOME/projects/Illyasviel"

FILE="$DEST/i.org"

if [ ! -d $DEST ];then
    mkdir -p $DEST
fi

if [ ! -f $FILE ];then
    touch $FILE
fi

TODAY_STR=$(date --rfc-3339=date)
IS_NEW_DAY=$(cat $FILE | grep "* $TODAY_STR" | wc -l)

if [ $IS_NEW_DAY = 0 ];then
    echo -e "* ${TODAY_STR}\n" >> $FILE
fi

if [ ! $# = 0 ];then
    echo -e "** $@\n" >> $FILE
fi
