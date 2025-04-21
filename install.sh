#!/bin/bash

CWD=$(pwd)

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

HOME=${SUDO_HOME:-$HOME}


# OS Detection for OS-specific commands
if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  ARCH=$(uname -m | grep -Eq 'aarch64|arm64' && echo 'arm64' || echo 'amd64')
  echo "Linux $ARCH detected"

  echo() {
    command echo "[Linux $(whoami)] $@"
  }

  # distro specific commands
  . /etc/os-release
  case $ID in
  ubuntu)
    echo 'Ubuntu detected, attemping to install dependencies'
    apt-get update
    apt-get install curl git unzip zsh lsd fzf
    ;;
  arch)
    echo 'Arch detected'
    ;;
  kali)
    echo 'Kali detected'
    apt-get install -y zsh fzf ripgrep zoxide tmuxinator lsd wl-clipboard
    ;;
  esac

  # install nerd fonts
  if [ ! -f ~/.local/share/fonts/FiraCodeNerdFont-Regular.ttf ]; then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
    unzip -o FiraCode.zip
    rm FiraCode.zip
    rm -f LICENSE README.md
    fc-cache -fv
    cd $CWD
  else
    echo 'FiraCodeNerdFont already installed, skipping'
  fi

  # neovim installation
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCH.appimage
  chmod +x nvim-linux-$ARCH.appimage

  mkdir -p /opt/nvim
  mv nvim-linux-$ARCH.appimage /opt/nvim/nvim

  # asdf installation
  curl -LO https://github.com/asdf-vm/asdf/releases/download/v0.16.7/asdf-v0.16.7-linux-$ARCH.tar.gz
  tar -xvzf asdf-v0.16.7-linux-$ARCH.tar.gz
  rm asdf-v0.16.7-linux-$ARCH.tar.gz
  mkdir -p /opt/asdf
  mv asdf /opt/asdf/asdf

  # enable asdf completion
  mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
  /opt/asdf/asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

  echo() {
    command echo "$@"
  }
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'macOS detected'

  # prefix echo command with [macOS]
  echo() {
    command echo "[macOS $(whoami)] $@"
  }

  if ! command -v brew &>/dev/null; then
    echo 'brew not found, installing...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # TODO: add brew zsh init script here
  else
    echo 'brew already installed'
  fi

  echo 'ensuring /usr/local/bin exists for starship installation...'
  [ ! -d /usr/local/bin ] && mkdir -p /usr/local/bin/

su $SUDO_USER <<"EOF"
  echo() {
    command echo "[macOS $(whoami)] $@"
  }

  # check if fira code exists, if not then install
  if [[ ! $(atsutil fonts -list | grep -i firacode) ]]; then
    echo 'Fira Code Nerd Font not found, installing...'
    brew install --cask font-fira-code-nerd-font
  fi

  echo "Running as $(whoami)"

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

  DEPENDENCIES=(neovim ripgrep asdf zoxide fzf lsd)
  for DEP in $DEPENDENCIES; do
    brew_install $DEP
  done
EOF

  mkdir -p $HOME/Library/Application\ Support/com.mitchellh.ghostty
  ln -sfn $(pwd)/ghostty/config $HOME/Library/Application\ Support/com.mitchellh.ghostty/config

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
