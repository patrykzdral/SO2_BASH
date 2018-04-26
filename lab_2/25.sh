#!/usr/bin/env bash

if [ "$#" != 2 ]; then
    echo "script has 2 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory parameter 1 not found"
    exit 2
fi
if [ ! -e $2 ]; then
    echo "parameter 2 not found"
    exit 3
fi

for file in `ls $1`; do
    echo $(readlink -f "$1/$file")
    if [ -L $1/$file ] && [ $(readlink -f "$1/$file") = $2 ] ; then
        echo $file
    fi
done