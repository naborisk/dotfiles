#!/bin/bash

cp .vimrc ~/.vimrc

# install dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s ~/.vim/bundles

vim -c 'call dein#install() | q!'