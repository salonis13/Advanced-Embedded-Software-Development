#!/bin/bash
#Script finder.sh for assignment 1 - AESD - Fall 2021
#Author: Saloni Shah

#filesdir is a path to a directory
filesdir=$1
#searchstr is a text string to be searched
searchstr=$2

#any statement is missing
if [ "$#" -ne 2 ] 
then
    echo "ERROR: Invalid number of arguments
    Argument #1: File Directory Path
    Argument #2: String to be searched in the directory"
    exit 1
#return 1 error value

#filesdir does not represent a directory
elif ! [ -d $filesdir ]
then
    echo "$1 - filesdir is not a directory"
    exit 1

else
    #print number of files in the directory and number of instances of given string
    echo "The number of files are $(find ${filesdir} -type f -print | wc -l) and the number of matching lines are $(grep -Rw ${filesdir} -e "${searchstr}" | wc -l)"
    exit 0
fi
