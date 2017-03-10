#!/bin/bash

function getval() {
    cat $1 | awk -F'=' -v varname="$2" '{ if ($1 == varname) print $2; }'
}

function randomstr() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1
}