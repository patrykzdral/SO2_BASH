#!/usr/bin/env bash


if [ "$#" != 1 ]; then
    echo "script has 1 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory parameter 1 not found"
    exit 2
fi


find $1  | while read path
do
    echo "c:${path//'/'/'\'}"

done
