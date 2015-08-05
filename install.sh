#!/bin/bash
set -euo pipefail

# safely get install.sh's directory (and, by proxy, the repo's directory)
MY_PATH="`dirname \"$BASH_SOURCE\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

if [[ -z "$MY_PATH" ]]; then
    printf "Something went very wrong. Cannot access install.sh's directory.\n"
    exit 1
fi

#echo "$MY_PATH"

printf "About to replace the dotfiles in \n\t\t$HOME\n"
printf "with their equivalents in \n\t\t$MY_PATH.\n\n"
printf "Are you sure? (Type 'please yes' to continue): "
read please yes
if [[ ( ! -v please ) || "$please" != "please" || \
      ( ! -v yes    ) || "$yes"    != "yes"     ]]; then
    printf "Quitting...no changes were made.\n"
    exit 2
fi

# now thanks to directory's naming convention, we can drop in symlinks as needed
for file in `ls`; do
    linkname="$HOME/.$file"
    target="$MY_PATH/$file"
    if [[ -e "$linkname" ]]; then
        printf "Deleting old dotfile: %s\n" $linkname
    fi
    printf "Creating symlink: %s -> %s\n" $linkname $target
done



