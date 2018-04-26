#!/usr/bin/env bash

awk -F: '$7 == "/bin/false" || $7 == "/usr/sbin/nologin" { print $1 }' /etc/passwd

