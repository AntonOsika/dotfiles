#!/bin/bash

FILES=".vimrc
.zshrc
.gitconfig
.gitignore
.gitattributes
.pylintrc
.ideavimrc
"

echo "not sure this will indeed overwrite, perhaps change setup_symlinks.sh to use: ln -f"

for f in $FILES
do
    read -p "Do you want to symlink $PWD/$f from home dir? Type [y] to OVERWRITE your old." -n 1 -r
    # move to a new line:
    echo   
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo Backing up $f to $HOME/${f}BACKUP and then overwriting.
        # Todo: check if it exists first
        mv $HOME/$f $HOME/${f}BACKUP
        ln -sv $PWD/$f $HOME/$f
    fi
done

echo "...done"

read -p "Do you want to symlink karabiner.json?" -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -sv $PWD/karabiner.json $HOME/.config/karabiner/karabiner.json

fi

read -p "Do you want to symlink prezto and necessary prezto runcoms from home dir? Old .zprezto will be moved to .zprezto_old" -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    mv $HOME/.zprezto $HOME/.zprezto_old
    ln -sv $PWD/prezto $HOME/.zprezto

    RUNCOM_FILES="zlogin
    zlogout
    zshenv
    zpreztorc
    zshrc
    zprofile"

    for f in $RUNCOM_FILES
    do
        ln -sv $HOME/.zprezto/runcoms/$f $HOME/.$f
    done
fi

# the following is zsh script:
#echo ""
#read -p "Do you want to symlink the prezto runcoms in $PWD/prezto/runcoms?" -n 1 -r
#echo ""
#
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#   echo "Trying to symlink prezto runcoms in $HOME to $PWD/prezto/runcoms"
#   setopt EXTENDED_GLOB
#   for rcfile in "$PWD"/prezto/runcoms/^README.md(.N); do
#       ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#   done
#fi
