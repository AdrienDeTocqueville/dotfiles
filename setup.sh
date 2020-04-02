# root config
#cp ~/dotfiles/xorg/custom.map /usr/share/kbd/keymaps/
#echo KEYMAP=custom >> /etc/vconsole.conf
#ln -s ~/.config/xorg/xorg.conf /etc/X11/xorg.conf

# standard config
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/gdbinit ~/.gdbinit
ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/elinks ~/.elinks

# standard .config
mkdir -p ~/.config
ln -s ~/dotfiles/config/i3	~/.config/i3
ln -s ~/dotfiles/config/polybar	~/.config/polybar
ln -s ~/dotfiles/config/xorg	~/.config/xorg
ln -s ~/dotfiles/config/nvim	~/.config/nvim
