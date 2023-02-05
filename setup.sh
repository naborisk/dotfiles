#!/bin/bash

# OS Detection for OS-specific commands
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo 'Linux detected'
  
  # distro specific commands
  . /etc/os-release
  case $ID in
    ubuntu)
      echo 'Ubuntu detected, attemping to install latest neovim'
      sudo apt-get install -y software-properties-common
      sudo add-apt-repository -y ppa:neovim-ppa/stable
      sudo apt-get -y update
      sudo apt-get install -y neovim
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
FILES_TO_INSTALL=".tmux.conf"
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
#mkdir -p $HOME/.config/nvim/lua

mkdir -p $HOME/.config
echo 'linking nvim directory'
ln -sfn $(readlink -f nvim) ~/.config/nvim

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install plugins
echo 'running PackerSync...'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

#--PROMPT INSTALLATION--
curl -sS https://starship.rs/install.sh | sh
