call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'

Plug 'sheerun/vim-polyglot'
Plug 'beyondmarc/hlsl.vim'
Plug 'jdsimcoe/abstract.vim'
" Git
Plug 'tpope/vim-fugitive'
" Search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" Tmux
" Plug 'wellle/tmux-complete.vim'
" Plug 'christoomey/vim-tmux-navigator'
call plug#end()

syntax on
colorscheme codedark
hi StatusLine ctermbg=93
hi StatusLineNC ctermbg=27
hi Comment ctermfg=28

set clipboard=unnamed
set mouse=a

set ai
set si
set hls
set nocp
set ruler
set number
set hidden
set autoread
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
set norelativenumber

au FocusGained * :checktime

filetype plugin on

hi clear CursorLine
hi CursorLineNR ctermfg=Red cterm=bold
hi CursorLine ctermbg=236 cterm=NONE

map K <Nop>

tnoremap <Esc> <C-\><C-n>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

nnoremap j gj
nnoremap k gk

nnoremap <C-t> :tabe %<CR>
nnoremap <C-f> :call fzf#run({'source': "git ls-files -- . ':!:*.meta' ':!:*.md'", 'sink': 'e', 'top': '40%', 'options': '-e'})<CR>
nnoremap <C-g> :Ag 
vnoremap <C-g> "ay:let cmd="Ag " . @a <bar> call histadd("cmd", cmd) <bar> execute cmd<CR>

" Tags
nnoremap <F1> :TagbarToggle<CR>
nnoremap <F2> :exec("tag ".expand("<cword>"))<CR>
nnoremap <F3> :sp<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <F4> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" ...
nnoremap <F5> :checktime<CR>

" Debugger (todo)
nnoremap <F7> :wa <bar> :make -j4 <CR> : <CR>

" Misc
nnoremap <F10> :call DeleteHiddenBuffers()<CR>:mksession! .vim.
nnoremap <F11> :call SwapHS()<CR>
nnoremap <F12> :noh<CR>

" gutentags
let gutentags_ctags_exclude=['*.meta', '*.md']

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
	elseif expand("%:e") == 'inl'
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


" SRP
autocmd BufNewFile,BufRead /mnt/c/Users/Unity/source/**/* set expandtab tabstop=4 foldmarker={,} foldmethod=marker foldlevelstart=99 foldlevel=99
autocmd BufNewFile,BufRead *.shader set syntax=hlsl
let gutentags_ctags_exclude+=['.yamato', '.github', 'TestProjects', 'Tools', 'LocalTestProjects']
