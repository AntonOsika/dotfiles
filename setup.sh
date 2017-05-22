#!/bin/sh

dir=~/dotfiles

read -p "Do you want to install .vimrc. Type [y] to OVERWRITE your old." -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo Backing up .vimrc up and then overwriting.
    mv $HOME/.vimrc $HOME/.vimrcBACKUP
    ln -s $dir/.vimrc ~/.vimrc
fi

read -p "Do you want to install .zshrc. Type [y] to OVERWRITE your old." -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo Backing up .zshrc up and then overwriting.
    mv $HOME/.zshrc $HOME/.zshrcBACKUP
    ln -s $dir/.zshrc ~/.zshrc
fi


source ~/.zshrc
source ~/.vimrc

echo "...done"
