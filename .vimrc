set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

set noswapfile
set nowb
set nobackup

syntax on
au BufNewFile,BufRead *.gradle set filetype=groovy
set expandtab
set shiftwidth=4
set tabstop=4
set ai
set si
set wrap
set number
set ssop-=options
set ssop-=folds
highlight LineNr ctermfg=240

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

let mapleader = ","

map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

if executable('ag')
      " Use Ag over Grep
      set grepprg=ag\ --nogroup\ --nocolor

      " Use ag in CtrlP for listing files. Lightning fast and respects
      ".gitignore
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

set path=$PWD/**

let projectPath = $PWD

function! SaveAndCloseProject(rootPath)
    execute "wall"
    execute "mksession! ".a:rootPath."/.vimproject.session"
    execute "qall"
endfunction

if !empty(glob(projectPath."/.vimproject.session"))
    execute "source ".projectPath."/.vimproject.session"
endif

noremap <leader>q :call SaveAndCloseProject(projectPath)<CR>

iabbrev @@ /**<cr>@file File description<cr>@author {@link https://github.com/Rhineheart Robin Swenson}<cr>/
iabbrev ££ /**<cr>@description Description<cr>@see {@link module/object}<cr><cr>@param {integer} param<cr>/
