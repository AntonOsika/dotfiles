#!/bin/bash
# TODO: separate .vimrc and init.vim files.
set -xe

mkdir -p $HOME/.config/nvim
ln -sv $PWD/.vimrc $HOME/.config/nvim/init.vim
ln -sv $PWD/coc-settings.json $HOME/.config/nvim/coc-settings.json

npm i -g pyright eslint prettier black typescript-language-server
