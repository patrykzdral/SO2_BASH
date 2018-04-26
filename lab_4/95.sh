#!/usr/bin/env bash

#wget -qO- http://tinyurl.com/doc-tajemnic | awk -F ':' '{print $0}'

wget -qO- http://tinyurl.com/doc-tajemnic | grep 'Prowadzący:' | awk  '{print $0}' | sort | uniq -c

wget -qO- http://tinyurl.com/doc-tajemnic | grep 'Prowadzący:' | sort | uniq -c | awk  'BEGIN {count=0}; {count=count+1} END {print count}'

