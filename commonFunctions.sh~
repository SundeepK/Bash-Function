#!/bin/bash


# Rename all image files in specified directory 
# Maxdepth 1 - goes 1 level deep
# If no directory is supplied - it defaults to user's home directory
function renameAllImageFiles {
  USER_HOME=$(eval echo ~${SUDO_USER})
  dir=${1:-$USER_HOME}

  if[! -f ()] then

    find $dir -maxdepth 1 \( -iname \*.png -o -iname \*.gif -o -iname \*.jpg \) -printf "'%p' '%h/OLD_%f'\n" | xargs -n2 mv
  fi
}

# Example
# renameAllImageFiles
# or
# renameAllImageFiles /home/john/images