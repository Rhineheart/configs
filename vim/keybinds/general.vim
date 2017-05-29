map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l 

map <C-a> ^
map <C-e> $ 

map <S-j> :call FunctionJump(0)<CR>
map <S-k> :call FunctionJump(1)<CR>

map <C-u> :call ParagraphJump(0)<CR>
map <C-i> :call ParagraphJump(1)<CR>

map <C-b> :NERDTreeToggle<CR>

let g:pDown='^\s*$\|\%$'
let g:pUp='^\s*$\|\%^'

if !exists("g:generalKeybindSetup")
    autocmd FileType javascript :let b:pDown='^\s*function\|\%$'
    autocmd FileType javascript :let b:pUp='^\s*function\|\%^'

    let g:generalKeybindSetup = 1
endif

function! FunctionJump(reverse)
    set nowrapscan
    if a:reverse
        if exists("b:pUp")
            execute "silent! ?" . b:pUp
        else
            execute "silent! ?" . g:pUp
        endif
    else
        if exists("b:pDown")
            execute "silent! /" . b:pDown
        else
            execute "silent! /" . g:pDown
        endif
    endif
    execute "normal z."
    set wrapscan
endfunction

function! ParagraphJump(reverse)
    set nowrapscan
    if a:reverse
        execute 'silent! ?^\s*$\|\%^'
    else
        execute 'silent! /^\s*$\|\%$'
    endif
    execute "normal z."
    set wrapscan
endfunction
