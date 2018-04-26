#!/usr/bin/env bash
#
# Zadanie 94
# Patryk Zdral
# 06.04.2018 11:15 TP
#
#
if [ "$#" != "1" ]; then
    echo "Skrypt należy uruchomić z jednym parametrem"
    exit 1
fi

if [ ! -d $1 ]; then
    echo "Wskazany katalog nie istnieje."
    exit 2
fi

find $1 |  while read path
do
    if [[   $path =~ ^.*\.py$ ]]; then

        echo "Wskazany plik jest plikiem py. $path"
        awk 'length < 80 && $0 !~ /^\t.*$/ { print "ta linia spelnia zalozenia: " $0 }' "$path"
        a=$(awk '$0 ~ /^import .$/ || $0 ~ /^import . from .$/  { if(NF==2) imports=imports"\n"$2 ; if(NF==4) imports=imports"\n"$2"\n"$4 } END { print imports }' "$path" | sort)
        b=$(awk '$0 ~ /^import .$/ || $0 ~ /^import . from .$/  { if(NF==2) imports=imports"\n"$2 ; if(NF==4) imports=imports"\n"$2"\n"$4 } END { print imports }' "$path")
        if [ ${a} != ${b} ] ; then
            echo "importy w pliku "$path" nie są w kolejności leksykograficznej"
        fi

        for file in ${a}; do
            if [ ! $(find /usr/lib/python2.7 -name ${file}) ]; then
                echo "nie zneleziono takiego pliku";
            fi
        done

    fi
done