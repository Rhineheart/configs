set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

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

function RhSource(file)
    exec "source $HOME/.vim/" . a:file
endfunction 

function RhKeys(file)
    call RhSource("keybinds/" . a:file)
endfunction 

call RhKeys("general.vim")

" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeDirArrowExpandable  = '+'
let g:NERDTreeDirArrowCollapsible = '-'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
