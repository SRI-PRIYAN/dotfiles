set cindent
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set expandtab
colorscheme pablo

nnoremap sout oSystem.out.printf("");<ESC>2hi
nnoremap scan oScanner input = new Scanner(System.in);<ESC>ggOimport java.util.Scanner;<ESC><C-o>o
nnoremap -i yiwgg}Oimport .<ESC>pA;<ESC>bbi
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
