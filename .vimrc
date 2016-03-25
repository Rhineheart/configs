set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'hail2u/vim-css3-syntax'

call vundle#end()
filetype plugin indent on

syntax on
set number
set path=$PWD/**

map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

set tabstop=4
set shiftwidth=4
set expandtab

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

