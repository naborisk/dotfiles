#!/bin/bash

curl https://raw.githubusercontent.com/naborisk/dotfiles/main/.vimrc > ~/.vimrc

# install dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s ~/.vim/bundles

vim -c 'call dein#install() | q!'
