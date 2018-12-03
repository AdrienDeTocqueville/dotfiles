set ai
set si
set hls
set ruler
set number
set wildmenu
set wildmode=longest,full
set showcmd

syntax on
colorscheme abstract

nmap <Left> <nop>
nmap <Right> <nop>
nmap <Up> <nop>
nmap <Down> <nop>

nmap <F2> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

ab #i #include
ab #n #ifndef
ab #e #endif