#!/bin/bash
#Script writer.sh for assignment 1 - AESD - Fall 2021
#Author: Saloni Shah

#filename with complete path
writefile=$1

#get directory name
dname=$(dirname "$writefile")

#get filename
bname=$(basename "$writefile")

#text string to be written in the file
writestr=$2

#any argument is missing
if [ "$#" -ne 2 ]
then
	echo "ERROR: Invalid number of arguments
	Argument #1: Filename with complete path
	Argument #2: String to be written in the file"
	exit 1
	#return 1 error value

else
	#check if the entered directory exists
	if [ -d "$dname" ]
	then
	#open the entered directory
	cd "$dname"
	
	#if the directory does not exist, make a new directory
	else
	mkdir -p "$dname"
	cd "$dname"
	fi
	
	#create a new file or overwrite existing file with given text string
	echo "${writestr}" > ${bname}
	if ! [[ -f "${writefile}" ]]
	then
	echo "Error in creating file"
	exit 1
	fi
	
	exit 0
fi
