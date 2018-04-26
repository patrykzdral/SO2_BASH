#!/usr/bin/env bash

if [ "$#" != "2" ]; then
    echo "Skrypt należy uruchomić z dwoma parametrami (ścieżki do katalogu, nazwa użytkownika)."
    exit 1
fi

if [ ! -d $1 ]; then
    echo "Wskazany katalog nie istnieje."
    exit 2
fi

getent passwd $2 > /dev/null
if [ $? -eq 2 ]; then
    echo "Użytkownik $2 nie istnieje."
    exit 3
fi

number_of_empty_files=0
number_of_empty_directories=0
number_of_empty_lol=0
find $1  | (while read path
do
    # echo $path
    # ls -A ${path}
    #if [ -f ${path} ]; then
    #    if [ ! -s ${path} ]; then
    #        number_of_empty_files=$[number_of_empty_files+1]
    #    fi
    #  1  echo $path
    #fi

    mod=$(date -r ${path} +%s)
    now=$(date +%s)
    days=$(expr \( $now - $mod \) / 86400)
    if [ ${days} -gt 365 ];then
        echo "Plik ${path} nie był zmieniany od roku"
    fi
    if [ -z "$(ls -A ${path})" ]; then
        number_of_empty_directories=$[number_of_empty_directories+1]
    fi
    if [ ! -s ${path} ]; then
        number_of_empty_files=$[number_of_empty_files+1]
    fi

    arr=($(ls -ld ${path}))
    if [ -f ${path} ] && [ ! ${2} = ${arr[2]} ]; then
        echo "użytkownik nie jest właścicielem pliku ${path}"
    fi
        perm_num=$(printf `stat --format '%a' ${path}` | tail -c 1 | head -c 1)
    if [ -f ${path} ] && [ "0" == ${perm_num} ] || [ "1" == ${perm_num} ] || [ "2" == ${perm_num} ] || [ "3" == ${perm_num} ]; then
        echo "użytkownik nie moze przeczytac pliku ${path}"
    fi



done
echo "liczba pusty katalogów: ${number_of_empty_directories}"
echo "liczba pusty katalogów: ${number_of_empty_files}"


)
