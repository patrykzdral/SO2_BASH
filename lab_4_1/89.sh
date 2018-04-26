#!/usr/bin/env bash
#
# Zadanie 89
# Patryk Zdral
# 06.04.2018 11:15 TP
#
#
lsof | awk  ' BEGIN {sum_of_opened_files=0 }; {column=NF-2 ; sum_of_opened_files+=$column ; mem=mem+$4} END { sum_of_opened_files = sum_of_opened_files /1024/1024 ; print sum_of_opened_files}'
