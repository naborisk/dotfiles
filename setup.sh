#!/bin/bash

# show commands
set -x

# OS Detection in case of wanting to do something OS-specific
if [[ "$OSTYPE" == "linux-gnu"* ]]; then

elif [[ "$OSTYPE" == "darwin"* ]]; then

fi

# copy the contents of .vimrc to home
cat .vimrc > ~/.vimrc

# append .zshrc
cat .zshrc >> ~/.zshrc

set +x