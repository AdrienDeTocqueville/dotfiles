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


#Vi mode and prompt
set -o vi

function set-prompt () {
    case ${KEYMAP} in
      (vicmd)      VI_MODE="green" ;;
      (main|viins) VI_MODE="cyan" ;;
      (*)          VI_MODE="green" ;;
    esac
    export PROMPT="${ret_status} %{$fg[$VI_MODE]%}%2~%{$reset_color%} $(git_prompt_info)"
}

function zle-line-init zle-keymap-select {
    set-prompt
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
