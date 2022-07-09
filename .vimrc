source $VIMRUNTIME/defaults.vim

set encoding=UTF-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/bundles/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.vim/bundles/dein')

" Let dein manage dein
" Required:
call dein#add('$HOME/.vim/bundles/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('mattn/emmet-vim')
call dein#add('preservim/nerdtree')
call dein#add('ryanoasis/vim-devicons')
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
call dein#add('vim-airline/vim-airline')

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

" enable NERDTree on startup
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" close vim if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctrl-b to toggle NERDTree
"map <C-b> :NERDTreeToggle<CR>

" use netrw as sidebar
map <C-b> :Lex<CR>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

" Color Scheme
colorscheme darcula

"" Color customizations (bg only work with some themes)
" Hide ~
hi EndOfBuffer ctermfg=bg

" Hide the | from window separators
set fillchars+=vert:\ 

" ctrl-z to undo in insert mode
imap <C-z> <esc> u i 

" Change emmet-vim expand key to tab
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" esc to escape terminal mode
tnoremap <esc> <C-\><C-n>

" Personal customizations
" Show line number
set nu
"set relativenumber

" Tab size and tab-to-space
set tabstop=2
set shiftwidth=2
set expandtab

" highlight while searching
set incsearch


" save as superuser
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command WQ :execute ':silent w !sudo tee % > /dev/null' | :q!
