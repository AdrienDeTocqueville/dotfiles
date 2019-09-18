# root config
#cp custom.map /usr/share/kbd/keymaps/
#cat KEYMAP=custom > /etc/vconsole.conf
#cp xorg.conf /etc/X11/xorg.conf

# standard config
ln -s ~/config/zshrc ~/.zshrc
ln -s ~/config/vimrc ~/.vimrc
ln -s ~/config/vim ~/.vim
ln -s ~/config/gdbinit ~/.gdbinit
ln -s ~/config/screenrc ~/.screenrc
ln -s ~/config/tmux.conf ~/.tmux.conf
ln -s ~/config/gitconfig ~/.gitconfig
ln -s ~/config/elinks ~/.elinks

# standard .config
mkdir -p ~/.config
ln -s ~/config/i3 ~/.config/i3
ln -s ~/config/i3status ~/.config/i3status

# X config
ln -s ~/config/xinitrc ~/.xinitrc
ln -s ~/config/Xmodmap ~/.Xmodmap
