set ai
set si
set hls
set ruler
set number
set wildmenu
set wildmode=longest,full
set wildignore=*.o,*~,*.pyc
set showcmd
set splitbelow
set splitright
set noswapfile
set cursorline

syntax on
colorscheme abstract

hi clear CursorLine
hi CursorLineNR ctermfg=Red cterm=bold

map K <Nop>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

nmap <F2> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F3> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F4> :exec("tag ".expand("<cword>"))<CR>
nmap <F11> :mksession! .vimsession<CR> \| :qa<CR>

ab #i #include
ab #n #ifndef
ab #e #endif

augroup BgHighlight
	autocmd!
	autocmd WinEnter * set number
	autocmd WinLeave * set nonumber
augroup END


set shiftwidth=0
"set tabstop=4
"set expandtab
