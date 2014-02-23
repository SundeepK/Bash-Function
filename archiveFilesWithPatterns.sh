#!/bin/bash

#used to archive files with a specific pattern using grep

#enhancements:
#use awk for more flexibility
#specify max directory depth

#Example usage:
#archiveFilesWithPattern.sh  -p 'hello word'
#archiveFilesWithPattern.sh  -d ./patternArchive -p 'hello word'

source ./libs/utils.sh

totalArgs=$#
path_to_archive=""
pattern=""

#get the inputs
while getopts "h?d:p:" opt; do
    case $opt in
    h|\?)
      echo " script can take -d as directory and -p as pattern"
      exit 0
    ;;
    d)
      path_to_archive="$OPTARG"
      [[ ! -d $path_to_archive ]] && exit_on_error "Error: directory supplied does not exist or is not a directory"
    ;;
    p)
      [[ ! -z $pattern ]] && exit_on_error "Error: pattern already supplied"
      pattern="$pattern $OPTARG"
    ;;
    esac
done

#check if we have been supplied a patternt to matcha against
[[ -z "$pattern" ]] && exit_on_error "Error: no pattern supplied"

#if no direcotry is supplied, then create one
if [[ -z "$path_to_archive" ]] 
then
  date=$(date +%d_%m_%Y_%k%M%S)
  path_to_archive="./keywordArchives_$date"
fi
 
#create the directory if one doesn't exist
[[ ! -d $path_to_archive ]] && (mkdir "$path_to_archive")

#search all directories, grep for pattern then copy to dir. Use max depth here if needed
(find . -name '*.*' -print0 | xargs -0 grep -Hl "$pattern" | xargs -I copy_file cp copy_file $path_to_archive)
#compress files and remove
tar -cvzf "$path_to_archive.tar.gz" $path_to_archive && rm -R $path_to_archive



