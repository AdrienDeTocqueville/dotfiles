autocmd!

call plug#begin('~/.vim/plugged')
Plug 'mhartington/oceanic-next'

Plug 'sheerun/vim-polyglot'
Plug 'beyondmarc/hlsl.vim'
Plug 'mbbill/undotree'
" Git
Plug 'tpope/vim-fugitive'
" Search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Tags
if $CONTEXT_MENU != "1"
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
endif
" LSP
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Tmux
" Plug 'wellle/tmux-complete.vim'
" Plug 'christoomey/vim-tmux-navigator'
" LaTeX
call plug#end()

call system("git rev-parse --git-dir > /dev/null 2>&1")
let is_git_repo = v:shell_error == 0

syntax on
colorscheme OceanicNext
"hi StatusLine ctermbg=93
"hi StatusLineNC ctermbg=27
"hi TabLine ctermfg=15 ctermbg=242
"hi TabLineSel cterm=underline ctermbg=0 ctermfg=7
hi Comment ctermfg=28
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set clipboard=unnamedplus
set mouse=a
set foldmethod=syntax
set foldlevelstart=99
set foldlevel=99

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
set inccommand=nosplit
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
nnoremap gp `[v`]

if is_git_repo
	nnoremap <C-f> :call fzf#run({'source': "git ls-files -- . ':!:*.meta' ':!:*.md'", 'sink': 'e', 'top': '40%', 'options': '-e'})<CR>
else
	nnoremap <C-f> :FZF<CR>
endif

nnoremap <C-t> :tabe %<CR>
nnoremap <C-g> :Grep 
vnoremap <C-g> "ay:call ExecWithHistory("Grep " . @a)<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" Tags (f13 = shift+f1)
nnoremap <F1>  :UndotreeToggle<CR>:UndotreeFocus<CR>
nnoremap <F13> :TagbarToggle<CR>
nnoremap <F2>  :call ExecWithHistory("tj " . expand("<cword>"))<CR>
nnoremap <F14> :call ExecWithHistory("tj " . @*)<CR>
nnoremap <F3>  :sp<CR>:call ExecWithHistory("tj " . expand("<cword>"))<CR>
nnoremap <F15> :vsp<CR>:call ExecWithHistory("tj " . expand("<cword>"))<CR>
nnoremap <F4>  :tab split<CR>:call ExecWithHistory("tj " . expand("<cword>"))<CR>
nnoremap <F16> :tab split<CR>:call ExecWithHistory("tj " . @*)<CR>:execute "normal! zz"<CR>

" ...
nnoremap <F5> :checktime<CR>

" Debugger (todo)
nnoremap <F6> :wa <bar> :make -j8 config=debug <CR>
nnoremap <F7> :wa <bar> :make -j8 config=dev <CR>
nnoremap <F8> :wa <bar> :make -j8 config=release <CR>

"nnoremap <F6> :wa <bar> :!pdflatex expand("%:r")<CR>:!pdf expand("%:r") . ".pdf"<CR>

" Misc
nnoremap <F10> :call DeleteHiddenBuffers()<CR>:mksession! .vim.
nnoremap <F11> :call SwapHS()<CR>
nnoremap <F12> :noh<CR>:cclose<CR>

" gutentags
let g:fzf_buffers_jump = 1
let gutentags_ctags_exclude=['*.meta', '*.md']

ab #i #include
ab #n #ifndef
ab #e #endif

command! -nargs=+ Grep execute 'silent grep! "<args>"' | botright cope
autocmd TermOpen * setlocal nonumber norelativenumber
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END

if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c:%m
endif


function! Edit()
    exec "!explorer.exe `wslpath -w %:p`"
endfun
function! Reveal()
    exec "!explorer.exe `wslpath -w %:p:h`"
endfun

function! SwapHS()
	let next_exts = { }
	let next_exts['cpp'] = ['inl', 'hpp', 'h']
	let next_exts['c'] = ['h']
	let next_exts['inl'] = ['h', 'cpp', 'c']
	let next_exts['h'] = ['cpp', 'c', 'inl']
	let next_exts['frag'] = ['vert']
	let next_exts['vert'] = ['frag']
	let next_exts['cs'] = ['cs.hlsl', 'hlsl']
	for next_ext in get(next_exts, expand("%:e"), [])
		let l:next_file = substitute(expand("%:."), expand("%:e")."$", next_ext, "")
		if filereadable(l:next_file)
			exec "e " l:next_file
			return
		endif
	endfor
	echo "No file to swap to"
endfun

function! DeleteHiddenBuffers()
    let tpbl=[]
    let closed = 0
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
            silent execute 'bwipeout!' buf
            let closed += 1
        endif
    endfor
    echo "Closed ".closed." hidden buffers"
endfunction

function! ExecWithHistory(cmd)
    echo a:cmd
    :call histadd("cmd", a:cmd)
    exec a:cmd
endfun

function! Hexdump()
    exec "%!hexdump -C"
endfun

" Syntax
autocmd BufNewFile,BufRead *.shader,*.compute,*.cginc,*.template,*.usf,*.ush set filetype=hlsl
autocmd BufNewFile,BufRead *.mat set filetype=yaml
autocmd BufNewFile,BufRead *.uss set filetype=css
autocmd BufNewFile,BufRead *.uxml set filetype=xml
let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'
let gutentags_ctags_exclude+=['.yamato', '.github', 'LocalTestProjects', 'TestProjects', 'Tools', 'Samples~', 'Documentation~', '*.Migration.cs', 'Documentation', 'Packages', 'artifacts', 'build', 'Art', 'Library']

" SRP / C#
au FileType cs,cpp,hlsl set expandtab tabstop=4 foldmarker={,} foldmethod=marker foldlevelstart=99 foldlevel=99
