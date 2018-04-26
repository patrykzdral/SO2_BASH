#!/usr/bin/env bash

if [ "$#" != "2" ]; then
    echo "script has 2 parameters"
    exit 1
fi
if [ ! -d "$1" ] && [ ! -r "$1" ]; then
    echo "directory parameter 1 not found"
    exit 2
fi
if [ ! -d "$2" ] && [ ! -w "$2" ] && [ ! -r "$2" ]; then
    echo "directory parameter 2 not found"
    exit 3
fi
func(){
for file in `ls "$1"`; do
    if [ -d "$1/$file" ]; then
        func "$1/$file" "$2"
    else
        if [ -r $1/$file ]; then
            echo $file
            exist=false
            for file2 in `ls "$2"`; do
                    if [ -r "$2/$file2" ]; then
                        if [ $(readlink -f "$2/$file2") = "$1/$file" ]; then
                            if [ "$2/$file2" -ef "$2/$file" ] && [ ! -L "$2/$file2" ]; then
                                break
                            fi
                            var="(realpath $2/$file2)"
                            if [ "$2/$file2" = "$var" ]; then
                                rm -rf "$2/$file2"
                            else
                                exist="true";

                        fi
                    fi
                fi
            done
        fi
        if [ $exist = "false" ]; then
            ln -s "$1/$file" "$2"
        fi
    fi
done

}

func "$1" "$2"

