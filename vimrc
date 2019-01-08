set ai
set si
set hls
set ruler
set number
set wildmenu
set wildmode=longest,full
set showcmd

syntax on

nmap <v_K> <nop>
nmap <Left> <nop>
nmap <Right> <nop>
nmap <Up> <nop>
nmap <Down> <nop>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

map <CR> o<Esc>

nmap <F2> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F11> :mksession! .vimsession<CR> \| :qa<CR>

ab #include #include
ab #ifndef #ifndef
ab #endif #endif
