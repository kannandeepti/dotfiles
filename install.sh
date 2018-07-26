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
printf "with their equivalents in \n\t\t$MY_PATH/dotfiles\n\n"
printf "Are you sure? (Type 'please yes' to continue): "
read please yes
if [[ ( ! -v please ) || "$please" != "please" || \
      ( ! -v yes    ) || "$yes"    != "yes"     ]]; then
    printf "Quitting...no changes were made.\n"
    exit 2
fi

# now thanks to directory's naming convention, we can drop in symlinks as needed
for file in `ls dotfiles`; do
    linkname="$HOME/.$file"
    target="$MY_PATH/dotfiles/$file"
    if [[ "$file" == "config" ]]; then
        continue
    fi
    if [[ -e "$linkname" || -h "$linkname" ]]; then
        printf "Deleting old dotfile: %s\n" $linkname
        rm -rf "$linkname"
    fi
    printf "Creating symlink: %s -> %s\n" $linkname $target
    ln -s "$target" "$linkname"
done


for file in `ls dotfiles/config`; do
    linkname="$HOME/.config/$file"
    target="$MY_PATH/dotfiles/config/$file"
    if [[ -e "$linkname" || -h "$linkname" ]]; then
        printf "Deleting old .config entry: %s\n" $linkname
        rm -rf "$linkname"
    fi
    printf "Creating symlink: %s -> %s\n" $linkname $target
    ln -s "$target" "$linkname"
done

echo "Would you like to install dependencies? (Y/n)"
read answer
if [[ -z "$answer" || $answer =~ "y" || $answer =~ "Y" ]]; then
    sudo apt-get install tmux
    sudo apt-get install xclip
    sudo apt-get install vim-gtk
    sudo apt-get install sox # for "play" command to give beeps
fi

echo "To get vim working, install plugins using :PlugInstall"
echo "To get tmux working, install plugins using C-q I"

