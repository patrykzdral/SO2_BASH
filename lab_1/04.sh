#!/usr/bin/env bash
# Zadanie 04
# Patryk Zdral
# 02.03.2018 11:15 TP

NUMBER=0
if [ "$#" != "1" ]; then
    echo "script has one parameter (path to directory)"
    exit 1
fi

if [ ! -d $1 ]; then
    echo "no such a directory"
    exit 1
fi

cd $1
for file in `ls -r -S *`; do
    if [ -x "$file" ]; then
        mv "$file" "$file.$NUMBER"
        NUMBER=$[NUMBER+1]
    fi
done