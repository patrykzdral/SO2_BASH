#!/usr/bin/env bash

if [ "$#" != "1" ]; then
    echo "Skrypt należy uruchomić z dwoma parametrami (ścieżki do katalogu, i plik)."
    exit 1
fi

if [[ !  $1 =~ ^.*\.csv.*$ ]]; then
    echo "Wskazany plik nie jest plikiem csv."
    exit 2
fi

awk -F, 'NF != "3" { print $0 }' $1

