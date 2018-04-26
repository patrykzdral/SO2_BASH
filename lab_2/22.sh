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
    echo $1/$file
    if [ -x $1/$file ] && [ -f $1/$file ]; then
        echo "trafilem na plik"
        ln  $1/$file $2
    fi

    if [ -x $1/$file ] && [ -d $1/$file ]; then
        echo "trafilem na katalog"
        ln -s  $1/$file $2
    fi
done