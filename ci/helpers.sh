#!/bin/bash

# getval <file> <key>
# 
# getval retrieves the value for a particular key from a file where
# key/value pairs are delimited by '='
# 
# Usage:
#   getval ci_var PUBLIC_IP
#
function getval() {
    cat $1 | awk -F'=' -v varname="$2" '{ if ($1 == varname) print $2; }'
}

# randomstr
#
# randomstr generates a pseudo-random alphnumeric string of 8 characters
#
function randomstr() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1
}