kead -p "Install essentials ? " yn
case $yn in
	[Yy]* )
	sudo apt-get install build-essential make git screen
	;;
esac

read -p "Install vim ? " yn
case $yn in
[Yy]* )
	sudo apt-get install vim

	cat >> ~/.vimrc <<- END
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
	END
	;;
esac

read -p "Install Node ? " yn
case $yn in
	[Yy]* )
	sudo apt-get install nodejs npm
	;;
esac

read -p "Install zsh ? " yn
case $yn in
	[Yy]* )
	sudo apt-get install zsh curl
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

	cat >> ~/.zshrc <<- END
	alias ga="git add .; git status"
	alias gs="git status"

	alias l="ls -l"
	alias ll="ls -al"
	alias lc="clear; clear; ls -l"

	alias mc="clear; clear; make"
	alias vim="vim -O"
	alias vi="vim -S .vimsession"
	alias dirs="dirs -vp"

	export PROMPT="%{\$fg[green]%}> %{\$fg[cyan]%}%2~%{\$reset_color%} \$(git_prompt_info)"
	export SCREENDIR=$HOME/.screen
	END
	;;
esac
