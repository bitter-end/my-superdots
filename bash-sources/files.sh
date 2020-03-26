#!/usr/bin/env bash


function file_is_zeroes {
    if [ $# -ne 1 ] ; then
        echo "USAGE: file_is_zeroes FILENAME"
        echo
        echo "    true/false based on the exit code"
        return 1
    fi

    file="$1"
    <"${file}" tr -d '\0' | read -n 1

    if [ $? -ne 0 ] ; then
        return 0
    else
        return 1
    fi
}


function swap {
    if [ $# -ne 2 ] ; then
        echo "USAGE: swap FILE1 FILE2"
        return 1
    fi

    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}


function dated_file {
    if [ $# -lt 1 ] ; then
        echo "USAGE: dated_file FILEPATH [EXT]"
        return 1
    fi
    filename=$(date +%Y%m%d)
    if [ ! -z "$2" ] ; then
        ext=".$2"
    fi
    fullpath="${1}/${filename}${ext}"
    $EDITOR "$fullpath"
}


