#!/usr/bin/env bash

for file in `ls $2`; do

        ln -s $2/$file $1

done