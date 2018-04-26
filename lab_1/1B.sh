#!/usr/bin/env bash
# Zadanie 1B
# Patryk Zdral
# 02.03.2018 11:15 TP
if [ "$#" != 2 ]; then
    echo "script has 2 parameters"
    exit 1
fi
if [ ! -d $1 ]; then
    echo "directory not found"
    exit 2
fi
if [ ! -r $2 ]; then
    echo "file with list not found"
    exit 3
fi
directory=${1}
directoryToFile=${2}
fileName=${2##*/}
firstDirectory=${1}
filesDontExistInDirectory=""
filesDontExistOnList=""

# $2##*/
compare(){

    for file in `cat $directoryToFile`; do

        if [[ ! ${file} =~ ^.*\.optional.*$ ]]; then
            if [ ! -e $1/$file ]; then
                filesDontExistInDirectory+=$file
                filesDontExistInDirectory+="   "

            fi
        fi

    done
    for file in `ls $directory`; do
        temp=false
        for plik in `cat $directoryToFile`; do
            if [ -d $directory/$file  ]; then
                cd $directory/$file
                directory=$directory/$file
                for file2 in `ls *`; do
                    if [ $file2 = $fileName ]; then
                        directoryToFile=$directory/$file2
                        compare $directory $directoryToFile
                    fi
                done

            else
                if [[ ${file} =~ ^.*\.optional.*$ ]] || [[ ${file} =~ ^exist.txt$ ]]; then
                    temp=true
                fi
                if [ $file = $plik ]; then
                    temp=true
                fi
            fi
        done
        if [ $temp = false ]; then
            filesDontExistOnList+=$file
            filesDontExistOnList+="   "
        fi
    done

}

compare $1 $2

echo "---those files don't exist in the directory in directory " >> "$firstDirectory/exist.txt"
echo $filesDontExistInDirectory >> $firstDirectory/exist.txt

echo "---those files don't exist on the list in directory " >> "$firstDirectory/exist.txt"
echo $filesDontExistOnList >> $firstDirectory/exist.txt
