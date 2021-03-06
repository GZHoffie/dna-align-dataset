#!/bin/bash

while getopts ":h" flag
do
    case "${flag}" in
        h) echo "Usage: $0 <sam_file>"
           exit;;
    esac
done


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <sam_file>"
    exit 9
fi


sam_file=$1
fasta_file=$2


tail -n +3 $sam_file | sed "s/\*/-/g" | while read line
do
    line_split=($line)
    if [ "${line_split[5]}" != "-" ]; then
        echo "${line_split[5]}"
    fi
done

