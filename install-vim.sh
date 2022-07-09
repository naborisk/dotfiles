#!/bin/bash

# install .vimrc
curl https://raw.githubusercontent.com/naborisk/dotfiles/main/.vimrc > ~/.vimrc

# install darcula theme
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim > ~/.vim/colors/darcula.vim

# install dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s ~/.vim/bundles/dein

vim -c 'call dein#install() | q!'

# fix garbled terminal
stty sane
