#!/bin/bash
PACKAGES="n tmux wget tree"
CASK_PACKAGES="font-fira-code visual-studio-code discord firefox slack iterm2"

# install homebrew
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install $PACKAGES

brew tap homebrew/cask-fonts

# avoid cask quitting if application already installed
for P in $CASK_PACKAGES; do
    brew install --cask $P
done

brew cleanup -s

# install pure prompt
sh install-pure.sh
