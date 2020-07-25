sudo apt update
sudo apt upgrade -y
sudo apt install -y curl git zsh ctags unzip silversearcher-ag

# Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
rm ~/.zshrc

# Neovim
mkdir ~/nvim
curl -fLo ~/nvim/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x ~/nvim/nvim.appimage
~/nvim/nvim.appimage --appimage-extract
mv squashfs-root/* ~/nvim
rm -rf squashfs-root

### Plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### Clipboard
mkdir ~/win32yank
curl -fLo ~/win32yank/yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x86.zip
unzip ~/win32yank/yank.zip -d ~/win32yank
mv ~/win32yank/win32yank.exe /mnt/d/Softwares/win32yank.exe
rm -rf ~/win32yank

# Config files
~/dotfiles/setup.sh
ln -s ~/dotfiles/open_with_nvim ~/open_with_nvim

# WSL specific aliases
echo 'vim() { ~/nvim/usr/bin/nvim -O $* }'	>> ~/.extrc
echo 'alias dl="/mnt/d/Downloads/"'		>> ~/.extrc
echo 'alias prgm="/mnt/d/Programs/"'		>> ~/.extrc
echo 'alias open="explorer.exe"'		>> ~/.extrc
echo 'export PATH="$PATH:/mnt/d/Softwares"'	>> ~/.extrc

exec zsh
