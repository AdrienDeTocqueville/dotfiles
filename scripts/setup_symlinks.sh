~/dotfiles/scripts/clear_symlinks.sh

ln -s ~/dotfiles/config/zshrc		~/.zshrc
ln -s ~/dotfiles/config/gdbinit		~/.gdbinit
ln -s ~/dotfiles/config/tmux.conf	~/.tmux.conf
ln -s ~/dotfiles/config/gitconfig	~/.gitconfig
ln -s ~/dotfiles/config/gitignore	~/.gitignore
ln -s ~/dotfiles/config/ignore		~/.ignore
ln -s ~/dotfiles/config/ctags		~/.ctags

mkdir -p ~/.vim
ln -s ~/dotfiles/scripts/db.py		~/.vim/db.py

mkdir -p ~/.config
ln -s ~/dotfiles/config/nvim		~/.config/nvim
ln -s ~/dotfiles/config/nvim/init.vim	~/.vimrc
