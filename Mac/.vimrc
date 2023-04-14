set number
set relativenumber
set cindent
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Places the Cursor in the same place where left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif
