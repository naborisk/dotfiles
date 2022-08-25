#!/bin/bash

# show commands
#set -x

# OS Detection in case of wanting to do something OS-specific
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo 'Linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'macOS'
fi

# backup the current .vimrc if found
if [ -f "$HOME/.vimrc" ]; then
   echo '.vimrc found, backing up to .vimrc.bak'
   mv $HOME/.vimrc $HOME/.vimrc.bak
fi

echo 'linking .vimrc'
ln -s $(pwd)/.vimrc $HOME/.vimrc



# append .zshrc
#cat .zshrc >> ~/.zshrc

#set +x
