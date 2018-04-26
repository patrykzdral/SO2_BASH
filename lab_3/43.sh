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

files_list_result=""
perm_num=""
find $1 -type f -perm /111 | (while read path
do
    echo ${path}
    perm_num=$(printf `stat --format '%a' ${path}` | tail -c 1 | head -c 1)
    if [ "1" == ${perm_num} ] || [ "3" == ${perm_num} ] || [ "5" == ${perm_num} ] || [ "7" == ${perm_num} ]; then
        files+= echo -e "${path}"
        continue
    fi

    perm_num=$(printf `stat --format '%a' ${path}` | tail -c 2 | head -c 1)
    if [ "1" == ${perm_num} ] || [ "3" == ${perm_num} ] || [ "5" == ${perm_num} ] || [ "7" == ${perm_num} ]; then
        group_name_of_owner=$(printf `stat -c %G ${path}`)
        if id -nG "$2" | grep -qw "$group_name_of_owner"; then
            files+= echo -e "${path}"
            continue
        fi
    fi

    perm_num=$(printf `stat --format '%a' ${path}` | tail -c 3 | head -c 1)
    if [ "1" == ${perm_num} ] || [ "3" == ${perm_num} ] || [ "5" == ${perm_num} ] || [ "7" == ${perm_num} ]; then
        username_of_owner=$(printf `stat -c %U ${path}`)
        if [ ${username_of_owner} == $2 ]; then
            files+= echo -e "${path}"
            continue
        fi
    fi
done
echo ${files_list_result})