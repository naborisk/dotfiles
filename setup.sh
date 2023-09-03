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
      sudo add-apt-repository -y ppa:neovim-ppa/unstable
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

  echo 'Intalling keymap...'
  mkdir -p $HOME/Library/LaunchAgents/
  cp ./macos-keymap/com.user.loginscript.plist $HOME/Library/LaunchAgents/

  echo 'Enabling key repeat'
  defaults write -g ApplePressAndHoldEnabled -bool false

  echo 'Disabling mouse acceleration'
  defaults write .GlobalPreferences com.apple.mouse.scaling -1

  if ! command -v nvim &> /dev/null
  then
    echo 'neovim not found, installing...'
    brew install neovim
  else
    echo 'neovim already installed'
  fi
fi

#--PROMPT INSTALLATION--
if ! command -v starship &> /dev/null
then
  echo 'starship not found, installing...'
  curl -sS https://starship.rs/install.sh | sh
else
  echo 'starship installed, skipping...'
fi

# ensure .config exists
mkdir -p $HOME/.config/

# add prompt init script if not exist in .zshrc

if ! grep -q 'starship init zsh' $HOME/.zshrc
then
  echo 'adding starship init script'
  echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc
fi

# install starship.toml in ~/.config
ln -sf $(pwd)/starship.toml $HOME/.config/starship.toml

#install files in home directory
FILES_TO_INSTALL=".tmux.conf .prettierrc"
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
mkdir -p $HOME/.config
echo 'linking nvim directory'
ln -sfn $(readlink -f nvim) ~/.config/nvim

#--.naborisk--
# symlink .naborisk
echo 'linking .naborisk'
ln -sfn $(pwd)/.naborisk $HOME/.naborisk

# add .naborisk/bin to PATH
echo 'adding .naborisk/bin to PATH'
grep -qxF 'export PATH=$PATH:$HOME/.naborisk/bin' $HOME/.zshrc || echo 'export PATH=$PATH:$HOME/.naborisk/bin' >> $HOME/.zshrc

# add alias to .zshrc
echo 'adding .naborisk/aliases to .zshrc'
grep -qxF 'source ~/.naborisk/aliases' $HOME/.zshrc || echo 'source ~/.naborisk/aliases' >> $HOME/.zshrc
