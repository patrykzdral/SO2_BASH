#!/usr/bin/env bash

if [ "$#" != 2 ]; then
    echo "script has 2 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory parameter 1 not found"
    exit 2
fi
if [ ! -d $2 ]; then
    echo "directory parameter 2 not found"
    exit 3
fi
for file in `ls $1`; do
    exist=false
    for file2 in `ls $2`; do
        if [ $(readlink -f "$2/$file2") = $1/$file ]; then
            exist=true;
        fi
    done
    if [ exist = false ]; then
        echo "nie istnieje"
        ln -s $1/$file $2
    fi

done