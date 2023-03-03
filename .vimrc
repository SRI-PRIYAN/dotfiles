set cindent
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set expandtab
colorscheme pablo

" CTRL + ENTER
inoremap <C-J> <ESC>ld$o<ESC>p==O

" Bracket Completion
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i

" Quote Completion
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
