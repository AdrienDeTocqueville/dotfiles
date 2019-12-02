set ai
set si
set hls
set nocp
set ruler
set number
set hidden
set wildmenu
set wildmode=longest,full
set wildignore=*.o,*~,*.pyc
set showcmd
set splitbelow
set splitright
set noswapfile
set cursorline
set shiftwidth=0
set laststatus=2
set scrolloff=5
set backspace=indent,eol,start

filetype plugin on

syntax on
silent! colorscheme abstract

hi clear CursorLine
hi CursorLineNR ctermfg=Red cterm=bold
hi CursorLine ctermbg=236 cterm=NONE

map K <Nop>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

nnoremap j gj
nnoremap k gk

nmap <C-t> :tabe %<CR>

nmap <F1> :noh<CR>
nmap <F2> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F3> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F4> :exec("tag ".expand("<cword>"))<CR>
nmap <F8> :wa <bar> :make debug -j4 <CR> : <CR>
nmap <F9> :wa <bar> :make -j4 <CR> : <CR>
nmap <F10> :mksession! .vimsession<CR>
nmap <F11> :call SwapHS()<CR>

ab #i #include
ab #n #ifndef
ab #e #endif

augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END


autocmd FileType python setlocal tabstop=4 expandtab
autocmd BufNewFile,BufRead *.vert set syntax=cs
autocmd BufNewFile,BufRead *.tesc set syntax=cs
autocmd BufNewFile,BufRead *.tese set syntax=cs
autocmd BufNewFile,BufRead *.frag set syntax=cs


call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
call plug#end()


function! SwapHS()
	if expand("%:e") == 'cpp'
		let l:new_ext = 'h'
	elseif expand("%:e") == 'c'
		let l:new_ext = 'h'
	elseif expand("%:e") == 'h'
		let l:new_ext = 'c*'
	elseif expand("%:e") == 'frag'
		let l:new_ext = 'vert'
	elseif expand("%:e") == 'vert'
		let l:new_ext = 'frag'
	endif

	let l:next_file = substitute(expand("%:."), expand("%:e")."$", l:new_ext, "")
	exec "e " l:next_file
endfun
