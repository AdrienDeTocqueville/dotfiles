export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
#source $HOME/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


alias ga="git add .; git status"
alias gu="git add -u; git status"
alias gs="git status"

alias l="ls -l"
alias ll="ls -la"
alias lc="clear; clear; ls -l"
alias mc="clear; clear; make"

alias k="gcc -Wall -Werror -Wextra"
alias vg="valgrind --leak-check=full"

alias vim="vim -O"
alias vi="vim -S .vimsession"
alias make="make -j"
alias gdb="gdb -q"
alias dirs="dirs -vp"

alias mongod="/mnt/d/Softwares/MongoDB/bin/mongod.exe"
alias arduino="/mnt/d/Softwares/Arduino/arduino.exe"
alias cl="clip.exe"
alias open="explorer.exe"

export PROMPT="%{$fg[green]%}> %{$fg[cyan]%}%2~%{$reset_color%} "
export SCREENDIR=$HOME/.screen
export DISPLAY=localhost:0.0

if [[ ! $TMUX ]]
then
	cd /mnt/d/Programs
fi
