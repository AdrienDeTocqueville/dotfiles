# Vim color scheme
git clone https://github.com/jdsimcoe/abstract.vim.git

mkdir -p ~/.vim/colors
mkdir -p ~/.vim/autoload
mv abstract.vim/colors/*.vim ~/.vim/colors/
mv abstract.vim/autoload/* ~/.vim/autoload/

# Configs
mv vimrc ~/.vimrc
cat ~/.zshrc zshrc > ~/.zshrc
