#!/bin/bash

# OS Detection for OS-specific commands
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo 'Linux detected'
  
  # distro specific commands
  . /etc/os-release
  case $ID in
    ubuntu)
      echo 'Ubuntu detected'
      ;;
    arch)
      echo 'Arch detected'
      ;;
  esac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'macOS detected'

  if ! command -v brew &> /dev/null
  then
    echo 'brew not found, installing...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo 'brew already installed'
  fi

  if ! command -v nvim &> /dev/null
  then
    echo 'neovim not found, installing...'
    brew install neovim
  else
    echo 'neovim already installed'
  fi
fi

#install files in home directory
FILES_TO_INSTALL=".vimrc .tmux.conf"
for FILE in $FILES_TO_INSTALL
do
  # backup the current file to install if found and is not a link
  if [[ -f "$HOME/$FILE" && ! -L "$HOME/$FILE" ]]; then
    echo "$FILE found, backing up to $FILE.bak"
    mv $HOME/$FILE $HOME/$FILE.bak
  fi

  echo "linking $FILE"
  ln -sf $(pwd)/$FILE $HOME/$FILE
done

#--NEOVIM CONFIGURATION--
mkdir -p $HOME/.config/nvim/lua

echo 'linking init.lua & plugins.lua'
ln -sf $PWD/nvim/init.lua $HOME/.config/nvim/init.lua
ln -sf $PWD/nvim/lua/plugins.lua $HOME/.config/nvim/lua/plugins.lua

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
