#!/bin/bash

# show commands
#set -x

# OS Detection in case of wanting to do something OS-specific
if [[ "$OSTYPE" == "linux-gnu"* ]]; then

    echo 'Linux'

elif [[ "$OSTYPE" == "darwin"* ]]; then

    echo 'macOS'

fi

# copy the contents of .vimrc to home
cat .vimrc > ~/.vimrc

# append .zshrc
cat .zshrc >> ~/.zshrc

set +x
