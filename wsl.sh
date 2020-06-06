sudo apt update
sudo apt upgrade -y
sudo apt install curl git zsh ctags unzip
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

mkdir ~/nvim
curl -fLo ~/nvim/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x ~/nvim/nvim.appimage
~/nvim/nvim.appimage --appimage-extract

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/nvim/yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x86.zip
unzip ~/nvim/yank.zip
mv ~/nvim/win32yank.exe /mnt/d/Softwares/win32yank.exe

rm ~/.zshrc
~/dotfiles/setup.sh

echo 'alias vim=~/nvim/squashfs-root/usr/bin/nvim'	>> ~/.extrc
echo 'alias dl="/mnt/d/Downloads/"'			>> ~/.extrc
echo 'alias prgm="/mnt/d/Programs/"'			>> ~/.extrc
echo 'export PATH="$PATH:/mnt/d/Softwares"'		>> ~/.extrc
