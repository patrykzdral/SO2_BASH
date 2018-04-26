#!/usr/bin/env bash

ps aux | awk  ' BEGIN {cpu=0 ; mem=0}; { cpu=cpu+$3 ; mem=mem+$4} END {print cpu; print mem}'


