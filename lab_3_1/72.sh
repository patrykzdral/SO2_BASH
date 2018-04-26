#!/usr/bin/env bash
#
# Zadanie 72
# Patryk Zdral
# 23.03.2018 11:15 TP
#
#

number_of_users=0
number_of_users_files=0
usings_of_sh=0
usings_of_dash=0
usings_of_bash=0
usings_of_rbash=0
users_shells=""

cat "/etc/passwd" |  (while read line
do

    number_of_users=$[number_of_users+1]
    username_of_owner=${line%%:*}
    shell=${line##*:}
    users+="${username_of_owner} "
    shells=$(cat /etc/shells)
    users_shells+="${shell}\n"
    if [[  ${shells} =~ .*${shell}.* ]]; then
        echo "Można sie zalogować na użytkownika ${username_of_owner}"
    fi

done
find $1 | (while read path
do
    username_of_file_owner=$(printf `stat -c %U ${path}`)
    # if [[  ${username_of_file_owner} = *${users}* ]]; then
    if [[  ${users} =~ .*${username_of_file_owner}.* ]]; then
        number_of_users_files=$[number_of_users_files+1]
    fi
    #if [  ]
done
 echo -e $users_shells | head -n -1 | sort | uniq -c | sort -n
 echo "Jest w sumie ${number_of_users} użytkowników"
 echo "W zadanym katalogu użytkownicy mają ${number_of_users_files} pliki"
 echo " ${usings_of_sh} używa powłoke /bin/sh"

  ))
