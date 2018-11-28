alias ga="git add .; git status"
alias gs="git status"

alias l="ls -l"
alias ll="ls -al"
alias lc="clear; clear; ls -l"

alias mc="clear; clear; make"
alias vim="vim -O"


export PROMPT="%{$fg[green]%}> %{$fg[cyan]%}%2~%{$reset_color%} $(git_prompt_info)"
export SCREENDIR=$HOME/.screen