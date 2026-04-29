#!/bin/bash

export CWD="$(pwd)"

if [[ $EUID -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

# Resolve the real user's home directory (SUDO_HOME is non-standard)
if [ -n "$SUDO_USER" ]; then
  HOME=$(eval echo ~"$SUDO_USER")
  export HOME
fi

# OS Detection for OS-specific commands
if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  ARCH_NVIM=$(uname -m | grep -Eq 'aarch64|arm64' && echo 'arm64' || echo 'x86_64')
  echo "Linux $ARCH_NVIM detected"

  echo() {
    command echo "[Linux $(whoami)] $@"
  }

  # distro specific commands
  . /etc/os-release
  case $ID in
    ubuntu)
      echo 'Ubuntu detected, attempting to install dependencies'
      apt-get update -y
      apt-get install -y curl git unzip zsh lsd fzf
      ;;
    arch)
      echo 'Arch detected'
      ;;
    cachyos)
      echo 'CachyOS detected'
      pacman -S --noconfirm zsh fzf ripgrep zoxide lsd
      ;;
    kali)
      echo 'Kali detected'
      apt-get install -y zsh fzf ripgrep zoxide tmuxinator lsd wl-clipboard libbz2-dev libreadline-dev libssl-dev
      ;;
  esac

  # install nerd fonts

  if [ -n "$SUDO_USER" ]; then
    su "$SUDO_USER" <<"EOF"
    if [ ! -f ~/.local/share/fonts/FiraCodeNerdFont-Regular.ttf ]; then
      mkdir -p ~/.local/share/fonts
      cd ~/.local/share/fonts
      curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
      unzip -o FiraCode.zip
      rm FiraCode.zip
      rm -f LICENSE README.md
      fc-cache -fv
      cd "$CWD"
    else
      echo 'FiraCodeNerdFont already installed, skipping'
    fi
EOF
  fi

  # neovim installation
  curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCH_NVIM.appimage"
  chmod +x "nvim-linux-$ARCH_NVIM.appimage"

  mkdir -p /opt/nvim
  mv "nvim-linux-$ARCH_NVIM.appimage" /opt/nvim/nvim

  # mise installation
  if ! command -v mise &>/dev/null; then
    echo 'mise not found, installing...'
    curl https://mise.run | sh
  else
    echo 'mise already installed, skipping...'
  fi

  echo() {
    command echo "$@"
  }
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'macOS detected'

  # prefix echo command with [macOS]
  echo() {
    command echo "[macOS $(whoami)] $@"
  }

  # Check for brew at known locations (brew is not in root's PATH on Apple Silicon)
  if [[ ! -x /opt/homebrew/bin/brew && ! -x /usr/local/bin/brew ]]; then
    echo 'brew not found, installing...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo 'brew already installed'
  fi

  # Set up brew in PATH for current session (needed on Apple Silicon)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  echo 'ensuring /usr/local/bin exists for starship installation...'
  [ ! -d /usr/local/bin ] && mkdir -p /usr/local/bin/

  su "$SUDO_USER" <<"EOF"
  echo() {
    command echo "[macOS $(whoami)] $@"
  }

  # Set up brew in PATH for this sub-shell
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

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

  echo 'Disabling dock autohide animation'
  defaults write com.apple.dock autohide-time-modifier -float 0.0 && killall Dock

  echo 'Disabling mouse acceleration'
  defaults write .GlobalPreferences com.apple.mouse.scaling -1

  brew_install() {
    echo "Installing $1"
    if brew list "$1" &>/dev/null; then
      echo "${1} is already installed"
    else
      brew install "$1" && echo "$1 is installed"
    fi
  }

  DEPENDENCIES=(neovim ripgrep mise zoxide fzf lsd)
  for DEP in "${DEPENDENCIES[@]}"; do
    brew_install "$DEP"
  done

  mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
  ln -sfn "$CWD/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
EOF

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
mkdir -p "$HOME/.config"

# install files in home directory
# files in home/ will be symlinked to $HOME
cd "$CWD/home"
FILES_TO_INSTALL=$(find . -type f | sed 's!./!!')

for FILE in $FILES_TO_INSTALL; do
  # backup the current file to install if found and is not a link
  if [[ -f "$HOME/$FILE" && ! -L "$HOME/$FILE" ]]; then
    echo "$FILE found, backing up to $FILE.bak"
    mv "$HOME/$FILE" "$HOME/$FILE.bak"
  fi

  # ensure parent directory exists
  mkdir -p "$(dirname "$HOME/$FILE")"

  # check if given path is directory
  TYPE=$(test -d "$FILE" && echo 'directory' || echo 'file')

  echo "linking $TYPE $FILE"
  ln -sfn "$(pwd)/$FILE" "$HOME/$FILE"
done
cd "$CWD"

#--NEOVIM CONFIGURATION--
echo 'linking nvim directory'
mkdir -p "$HOME/.config"
ln -sfn "$(readlink -f nvim)" "$HOME/.config/nvim"

echo 'linking .zsh directory'
ln -sfn "$(readlink -f .zsh)" "$HOME/.zsh"
