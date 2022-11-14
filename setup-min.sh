#!/bin/bash

BASEURL="https://raw.githubusercontent.com/naborisk/dotfiles"

if ! command curl &> /dev/null then
  echo 'curl not installed, exiting...'
  exit
fi

mkdir -p $HOME/.config/nvim/lua/

curl $BASEURL/nvim/init.lua > $HOME/.config/nvim/init.lua
