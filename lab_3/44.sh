#!/usr/bin/env bash

if [ "$#" != 1 ]; then
    echo "script has 1 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory parameter 1 not found"
    exit 2
fi

var=""
variable="directories: \n "
find $1 -mtime -30 | grep .git | ( while read path
do
    var=${path%/.git*}
    if [[ ! $variable = *${path%/.git*}* ]]; then
        variable="${variable}\n${var}"
    else
        continue;
    fi
done
echo -e "${variable}")


