#!/bin/sh

FILES=".vimrc
.zshrc
.gitconfig
.gitignore
.gitattributes"

for f in $FILES
do
	read -p "Do you want to symlink $PWD/$f from home dir? Type [y] to OVERWRITE your old." -n 1 -r
	echo    # move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo Backing up $f and then overwriting.
		mv $HOME/$f $HOME/${f}BACKUP
		ln -s $PWD/$f $HOME/$f
	fi
done

echo "...done"


echo ""
read -p "Do you want to symlink the prezto runcoms in $PWD/prezto/runcoms?" -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Trying to symlink prezto runcoms in $HOME to $PWD/prezto/runcoms"
	setopt EXTENDED_GLOB
	for rcfile in "$PWD"/prezto/runcoms/^README.md(.N); do
	    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
	done
fi
