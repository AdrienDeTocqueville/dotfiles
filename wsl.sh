sudo apt install curl git zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rm ~/.zshrc
./setup.sh

tee << END | ~/.extrc
alias dl="/mnt/d/Downloads/"
alias prgm="/mnt/d/Programs/"
export PATH="$PATH:/mnt/d/Softwares"
END
