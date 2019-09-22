# ZSH things
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
#source $HOME/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# Windows
alias cl="clip.exe"
alias open="explorer.exe"


# Arch
alias pacman="sudo pacman"

xnvidia() {
	mv ~/.config/xorg/xorg.conf.nvidia ~/.config/xorg/xorg.conf 
	startx ~/.config/xorg/xinitrc.nvidia
}

xintel() {
	mv ~/.config/xorg/xorg.conf.intel ~/.config/xorg/xorg.conf 
	startx ~/.config/xorg/xinitrc.intel
}


# Standard
alias ga="git add .; git status"
alias gap="git add -p"
alias gu="git add -u; git status"
alias gs="git status"
alias gg="git grep -n"

alias ls="\ls -lh --color=tty --time-style=+'  %d %b %Y %H:%M '"
alias l="ls"
alias ll="ls -a"
alias lc="clear; clear; ls"
alias dir="dir --color"

alias k="gcc -Wall -Werror -Wextra"
alias vg="valgrind --leak-check=full"

alias vim="vim -O"
alias vi="vim -S .vimsession"
alias make="make -j4"
alias gdb="gdb -q"
alias dirs="dirs -vp"
alias df="df -h"
alias du="du -sh"

#alias ctags="ctags -R --sort=yes --fields=+iaS --extra=+q ."


# Functions
help() {
	bash -c "help $1"
}


export PROMPT="%{$fg[green]%}> %{$fg[cyan]%}%2~%{$reset_color%} "


source $HOME/.extrc
