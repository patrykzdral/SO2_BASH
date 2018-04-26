#!/usr/bin/env bash

if [ "$#" != 1 ]; then
    echo "script has 1 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory parameter 1 not found"
    exit 2
fi
var=$(whoami)
echo $var
# ! -user "$(whoami)"
find $1 ! -user "$(whoami)" | while read var1
do
    arr=($(ls -ld "$var1"))
    if [  -f "$var1" ] && [ ! $(whoami) = ${arr[2]} ]; then
        echo "ścieżka:${var1}   użytkownik:${arr[2]}    grupa:${arr[3]}   uprawnienia:$(stat --format '%a' ${var1})"
    else
        echo "ścieżka:${var1}   użytkownik:${arr[2]}    grupa:${arr[3]}"
    fi
    #ls -ld "$var1"
    #echo $arr | cut " " ${1}
    #echo

done