#!/bin/bash

FILES=".vimrc
.zshrc
.gitconfig
.gitignore
.gitattributes
.pylintrc
.ideavimrc
.xsessionrc
.tmux.conf
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
    ln -svf $PWD/prezto $HOME/.zprezto

    RUNCOM_FILES="zlogin
    zlogout
    zshenv
    zpreztorc
    zprofile"

    for f in $RUNCOM_FILES
    do
        ln -svf $HOME/.zprezto/runcoms/$f $HOME/.$f
    done
fi

read -p "Do you want to symlink copyq command?" -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -sv $PWD/copyq-commands.ini ~/.config/copyq/copyq-commands.ini
    echo "Linked copyq commands to ~/.config/copyq"
fi

# Haven't made this work yet (see xkeysnail repo):
# read -p "Do you want to sudo symlink xkeysnail service" -n 1 -r
# echo    # move to a new line

# if [[ $REPLY =~ ^[Yy]$ ]]
# then
#     sudo ln -sv $PWD/xkeysnail.service /etc/systemd/system/xkeysnail.service
#     echo "Run systemctl start xkeysnail.service to start manually, systemctl preset [] to start at boot, and systemctl status []"
# fi

# This stuff could be done with `echo >` instead
# read -p "Do you want to sudo symlink apparmor xkeysnail" -n 1 -r
# echo    # move to a new line

# if [[ $REPLY =~ ^[Yy]$ ]]
# then
#     sudo ln -sv $PWD/usr.local.bin.xkeysnail /etc/apparmor.d/usr.local.bin.xkeysnail
# fi
