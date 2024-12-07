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
  kali)
    echo 'Kali detected'
    sudo apt-get install -y neovim fzf ripgrep zoxide tmuxinator
    ;;
  esac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'macOS detected'

  # prefix echo command with [macOS]
  echo() {
    command echo "[macOS] $@"
  }

  if ! command -v brew &>/dev/null; then
    echo 'brew not found, installing...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # TODO: add brew zsh init script here
  else
    echo 'brew already installed'
  fi

  echo 'Intalling macOS keymap...'
  mkdir -p $HOME/Library/LaunchAgents/
  cp ./macos-keymap/com.user.loginscript.plist $HOME/Library/LaunchAgents/

  echo 'Enabling key repeat'
  defaults write -g ApplePressAndHoldEnabled -bool false

  echo 'Disabling mouse acceleration'
  defaults write .GlobalPreferences com.apple.mouse.scaling -1

  if ! command -v nvim &>/dev/null; then
    echo 'neovim not found, installing...'
    brew install neovim
  else
    echo 'neovim already installed'
  fi

  # return echo to normal
  echo() {
    command echo "$@"
  }
fi

#--PROMPT INSTALLATION--
if ! command -v starship &>/dev/null; then
  echo 'starship not found, installing...'
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
  echo 'starship installed, skipping...'
fi

# ensure .config exists
mkdir -p $HOME/.config/

# install files in home directory
# files in home/ will be symlinked to $HOME
cd home
FILES_TO_INSTALL=$(find . -type f | sed 's!./!!')

for FILE in $FILES_TO_INSTALL; do
  # backup the current file to install if found and is not a link
  if [[ -f "$HOME/$FILE" && ! -L "$HOME/$FILE" ]]; then
    echo "$FILE found, backing up to $FILE.bak"
    mv $HOME/$FILE $HOME/$FILE.bak
  fi

  # check if given path is directory
  TYPE=$(test -d $FILE && echo 'directory' || echo 'file')

  echo "linking $TYPE $FILE"
  ln -sfn $(pwd)/$FILE $HOME/$FILE
done
cd ..

#--NEOVIM CONFIGURATION--
echo 'linking nvim directory'
ln -sfn $(readlink -f nvim) ~/.config/nvim

echo 'linking .zsh directory'
ln -sfn $(readlink -f .zsh) ~/.zsh
