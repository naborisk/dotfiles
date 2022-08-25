#!/bin/bash

FILES_TO_INSTALL=".vimrc .tmux.conf"

# OS Detection in case of wanting to do something OS-specific
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo 'Linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'macOS'
fi

#install files in home directory
for FILE in $FILES_TO_INSTALL
do
  echo $FILE
  # backup the current file to install if found
  if [ -f "$HOME/.vimrc" ]; then
    echo "$FILE found, backing up to $FILE.bak"
    mv $HOME/$FILE $HOME/$FILE.bak
  fi

  echo "linking $FILE"
  ln -s $(pwd)/$FILE $HOME/$FILE
done

mkdir -p $HOME/.config/nvim/lua

echo 'linking init.lua & plugins.lua'
ln -sf $PWD/nvim/init.lua $HOME/.config/nvim/init.lua
ln -sf $PWD/nvim/lua/plugins.lua $HOME/.config/nvim/lua/plugins.lua
