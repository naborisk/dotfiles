#!/bin/bash

CWD=$(pwd)

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
    sudo apt-get install -y zsh neovim fzf ripgrep zoxide tmuxinator lsd wl-clipboard
    ;;
  esac

  # install nerd fonts
  FONT_NAME=FiraCode

  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/$FONT_NAME.zip"
  unzip -o $FONT_NAME.zip
  rm $FONT_NAME.zip
  rm -f LICENSE README.md
  fc-cache -fv
  cd $CWD

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

  # check if fira code exists, if not then install
  if [[ ! $(atsutil fonts -list | grep -i firacode) ]]; then
    echo 'Fira Code Nerd Font not found, installing...'
    brew install --cask font-fira-code-nerd-font
  fi

  echo 'ensuring /usr/local/bin exists for starship installation...'
  [ ! -d /usr/local/bin ] && sudo mkdir -p /usr/local/bin/

  echo 'Enabling key repeat'
  defaults write -g ApplePressAndHoldEnabled -bool false

  echo 'Enabling dock autohide'
  defaults write com.apple.dock autohide -bool TRUE

  if [ $(defaults read com.apple.dock autohide-time-modifier) -ne 0 ]; then
    echo 'Disabling dock autohide animation'
    defaults write com.apple.dock autohide-time-modifier -float 0.0 && killall Dock
  fi

  echo 'Disabling mouse acceleration'
  defaults write .GlobalPreferences com.apple.mouse.scaling -1

  brew_install() {
      echo "Installing $1"
      if brew list $1 &>/dev/null; then
          echo "${1} is already installed"
      else
          brew install $1 && echo "$1 is installed"
      fi
  }

  DEPENDENCIES="neovim ripgrep asdf zoxide fzf lsd"

  for DEP in $DEPENDENCIES; do
    brew_install $DEP
  done

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
