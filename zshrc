# ZSH things
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh
#source $HOME/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# disable zsh git completion
compdef -d git checkout



# Arch
alias pacman="sudo pacman"
alias pdf="apvlv"
alias dos2unix="perl -pi -e 's/\r\n/\n/g'"
alias dl="cd $HOME/downloads"

x() {
	if [ -z "$driver" ] ; then
		driver="intel"
	fi
	cp ~/.config/xorg/xorg.conf.$driver ~/.config/xorg/xorg.conf
	startx ~/.config/xorg/xinitrc
}


# Standard
stty -ixon # disable ctrl-s / ctrl-q

alias ga="git add .; git status ."
alias gu="git add -u; git status ." # doesn't add newly created files
alias gap="git add -p"
alias gs="git status ."
alias gg="git grep -n"
alias gd="git diff"
alias gdc="git diff --cached"
alias gc="git checkout"
alias gl="git pull"
alias gp="git push"

alias ls="\ls -lh --color=tty --time-style=+'  %d %b %Y %H:%M '"
alias l="ls"
alias ll="ls -a"
alias lc="clear; clear; ls"
alias dir="dir --color"
alias cp="cp -i"
alias mv="mv -i"

alias k="gcc -Wall -Werror -Wextra"
alias vg="valgrind --leak-check=full"

alias make="make -j$(nproc)"
alias gdb="gdb -q"
alias dirs="dirs -vp"
alias df="df -h"
alias du="du -sh"

#alias ctags="ctags -R --sort=yes --fields=+iaS --extra=+q ."


# Functions
help() {
	bash -c "help $1"
}

nstr() {
	num=$1
	str=$2
	v=$(printf "%-${num}s" "$str")
	echo "${v// /$str}"
}

hex() {
	echo $((16#$1))
}

vi() {
	if [ -z "$1" ] ; then
		vim -S .vim.*
	else
		vim -S .vim.$1
	fi
}


export PROMPT="%{$fg[green]%}> %{$fg[cyan]%}%2~%{$reset_color%} "


source $HOME/.extrc
