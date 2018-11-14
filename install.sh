# Essential packages
sudo apt-get install build-essential
sudo apt-get install make
sudo apt-get install zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ZSH config
echo "alias ga="git add .; git status"
alias gs="git status"
alias l="ls -l"
alias ll="ls -al"
alias lc="clear; ls -1"
alias mc="clear; make"
export PROMPT=\"-> %{$fg[cyan]%}%2~%{$reset_color%} $(git_prompt_info)\"
cd /mnt/c/Users/Adrien/Documents/Programs/" >> ~/.zshrc


# Vim color scheme
git clone https://github.com/jdsimcoe/abstract.vim.git

mkdir -p ~/.vim/colors
mkdir -p ~/.vim/autoload
mv abstract.vim/colors/*.vim ~/.vim/colors/
mv abstract.vim/autoload/* ~/.vim/autoload/

# Vim config
echo "set ai
set si
set hls
set tabstop=4
set number
set ruler
set wildmenu
set showcmd

syntax on
colorscheme abstract" > ~/.vimrc

# Useful packages
sudo apt-get install clang
sudo apt-get install nodejs npm
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install man-db
sudo apt-get install manpages-dev
sudo apt-get install glibc-doc