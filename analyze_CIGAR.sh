#!/bin/bash

while getopts ":h" flag
do
    case "${flag}" in
        h) echo "Usage: $0 <cigar_file>"
           exit;;
    esac
done


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <cigar_file>"
    exit 9
fi


cigar_file=$1

echo "Number of highways per alignment: $(calc $(tr -cd '=' < $cigar_file | wc -c)/$(wc -l < $cigar_file))"
echo "Percentage of mismatch: $(calc $(tr -cd 'X' < $cigar_file | wc -c)/$(wc -l < $cigar_file)/100)"
echo "Percentage of insert: $(calc $(tr -cd 'I' < $cigar_file | wc -c)/$(wc -l < $cigar_file)/100)"
echo "Percentage of delete: $(calc $(tr -cd 'D' < $cigar_file | wc -c)/$(wc -l < $cigar_file)/100)"