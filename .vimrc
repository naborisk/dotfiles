source $VIMRUNTIME/defaults.vim

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.vim/bundles')

" Let dein manage dein
" Required:
call dein#add('$HOME/.vim/bundles/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('mattn/emmet-vim')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" Change emmet-vim expand key to tab
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Personal customizations
set nu
set relativenumber

set tabstop=2
set shiftwidth=2
set expandtab

" macOS's vi doesnt have syntax on by default
syntax on

" save as superuser
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command WQ :execute ':silent w !sudo tee % > /dev/null' | :q!
