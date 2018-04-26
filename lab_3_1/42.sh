#!/usr/bin/env bash
#
# Zadanie 42
# Patryk Zdral
# 23.03.2018 11:15 TP
#
#
if [ "$#" != "2" ]; then
    echo "Skrypt należy uruchomić z dwoma parametrami (ścieżki do katalogu, i plik)."
    exit 1
fi

if [ ! -d $1 ]; then
    echo "Wskazany katalog nie istnieje."
    exit 2
fi


find $1 |  while read path
do
    if [ $(readlink -f ${2}) = ${path}  ] ; then
        if [ "$2" -ef "${path}" ] && [ ! -L "${path}" ]; then
            echo "Dowiazanie twarde: ${path}"
        fi
        if [ -L "${path}" ]; then
            echo "Dowiazanie miekkie: ${path}"
        fi
    fi
done

