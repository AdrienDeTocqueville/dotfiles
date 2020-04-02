call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'beyondmarc/hlsl.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'jdsimcoe/abstract.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on
colorscheme abstract


set tabstop=4
set expandtab
set norelativenumber

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
nmap <C-f> :FZF -e<CR>

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

function! DeleteHiddenBuffers()
    let tpbl=[]
    let closed = 0
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
            silent execute 'bwipeout' buf
            let closed += 1
        endif
    endfor
    echo "Closed ".closed." hidden buffers"
endfunction
