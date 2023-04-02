#!/bin/bash

BASEURL="https://raw.githubusercontent.com/naborisk/dotfiles"

if ! command curl &> /dev/null then
  echo 'curl not installed, exiting...'
  exit
fi

# tmux
mv ~/.tmux.conf ~/.tmux.conf.bak
curl $BASEURL/.tmux.conf > ~/.tmux.conf

# starship
if ! command -v starship &> /dev/null
then
  echo 'starhip not found, skipping config'
else
  echo 'starship installed, applying config'
  mkdir -p $HOME/.config
  curl $BASEURL/starship.toml > $HOME/.config/starship.toml
fi
