#!/usr/bin/env bash

cat '/etc/passwd' |  grep ':/:' | awk -F ':' '{print $1}'
cat '/etc/passwd' |  grep ':/dev/null:' | awk -F ':' '{print $1}'
