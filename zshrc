alias ga="git add .; git status"
alias gs="git status"

alias l="ls -l"
alias ll="ls -al"
alias lc="clear; ls -l"
alias mc="clear; clear; make"

alias k="gcc -Wall -Werror -Wextra"
alias vg="valgrind --leak-check=full"

alias vim="vim -O"
alias vi="vim -S .vimsession"
alias dirs="dirs -vp"


export PROMPT="%{$fg[green]%}> %{$fg[cyan]%}%2~%{$reset_color%} $(git_prompt_info)"
export SCREENDIR=$HOME/.screen
