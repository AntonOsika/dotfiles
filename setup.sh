#!/bin/sh

dir=~/dotfiles

FILES=".vimrc
.zshrc
.gitconfig
.gitignore
.gitattributes"

for f in $FILES
do
	read -p "Do you want to symlink $f from home dir? Type [y] to OVERWRITE your old." -n 1 -r
	echo    # move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo Backing up $f and then overwriting.
		mv $HOME/$f $HOME/${f}BACKUP
		ln -s $dir/$f ~/$f
	fi
done

echo "...done"
