set ai
set si
set hls
set nocp
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
set shiftwidth=0
set laststatus=2
set backspace=indent,eol,start

filetype plugin on
set omnifunc=omni#cpp#complete#Main

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

nmap <F2> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F3> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F4> :exec("tag ".expand("<cword>"))<CR>
nmap <F11> :mksession! .vimsession<CR> \| :qa<CR>

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

match ErrorMsg '\%>80v.\+'

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
