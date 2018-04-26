#!/usr/bin/env bash
#
# Zadanie 26
# Patryk Zdral
# 09.03.2018 11:15 TP
#
#
if [ "$#" != 1 ]; then
    echo "script has 2 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory parameter 1 not found"
    exit 2
fi
path=""
for file in `ls $1`; do
    if [ -L $1/$file ] && [ ! -d $1/$file ] ; then
        path=$(readlink -f "$1/$file")
        rm -rf $1/$file
        ln $path $1
    fi
done