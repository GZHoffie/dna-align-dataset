#!/bin/bash

while getopts ":h" flag
do
    case "${flag}" in
        h) echo "Usage: $0 <sam_file> <fasta_file>"
           exit;;
    esac
done


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <sam_file> <fasta_file>"
    exit 9
fi


sam_file=$1
fasta_file=$2


tail -n +3 $sam_file | head -n 500 | sed "s/\*/-/g" | while read line
do
    line_split=($line)
    if [ "${line_split[5]}" != "-" ]; then
        echo "<${line_split[9]}"
        echo ">$(tail -n +2 ${fasta_file} | tr -d \\n | tail -c +${line_split[3]} | head -c ${#line_split[9]})"
    fi
done

