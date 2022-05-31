# Dotfiles
Various customizations for my own use

## .vimrc
```vim
source $VIMRUNTIME/defaults.vim

set nu
set relativenumber

set tabstop=4
set shiftwidth=4
set expandtab

" macOS's vi doesnt have syntax on by default
syntax on
```
This .vimrc is mostly just to make tab behave normally, and to enable syntax highlighting on macOS's vim

## .zshrc
```sh
# custom entries

alias c=clear
alias l=ls
alias ll='ls -l'
alias :q=exit

# set vi keybindings in terminal
set -o vi
```
My personal commonly used shortcuts
