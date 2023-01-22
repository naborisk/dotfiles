#!/bin/bash

BASEURL="https://raw.githubusercontent.com/naborisk/dotfiles"

if ! command curl &> /dev/null then
  echo 'curl not installed, exiting...'
  exit
fi

# tmux
mv ~/.tmux.conf ~/.tmux.conf.bak
curl $BASEURL/.tmux.conf > ~/.tmux.conf
