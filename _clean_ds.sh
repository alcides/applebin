#!/bin/bash

# Cleans the .DS_Store files inside the folder.
# usage: _clean_ds.sh <directory>

if [ ! -e "$1" ]
then
	find $1 -name .DS_Store -delete
fi