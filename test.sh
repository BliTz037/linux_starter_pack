#!/usr/bin/env bash

# Add Monokaï theme to Vim
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Adding Monokaï theme to Vim"
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -O ~/.vim/colors/monokai.vim
echo "syntax enable" >> ~/.vimrc
echo "colorscheme monokai" >> ~/.vimrc