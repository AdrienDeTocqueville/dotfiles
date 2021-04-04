#!/bin/zsh

if [ -d "/mnt/d" ] ; then
BINDIR="/mnt/d/Softwares"
else
BINDIR="/mnt/c/Softwares"
fi

APPDATA=$(echo "$PATH" | grep -o "[^:]*WindowsApps[^:]*")
APPDATA="$APPDATA/../.."

sudo ln -s $BINDIR/Git/bin/git.exe  /bin/git

sudo apt install -y unzip silversearcher-ag

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
mv ~/win32yank/win32yank.exe "$BINDIR" && rm -rf ~/win32yank

# Config files
~/dotfiles/setup.sh
ln -s ~/dotfiles/open_with_nvim ~/open_with_nvim
\cp settings.json $APPDATA/Packages/Microsoft.WindowsTerminal*/LocalState

# WSL specific aliases
echo 'vim() { ~/nvim/usr/bin/nvim -O $* }'	>> ~/.extrc
echo 'goto() { cd $(wslpath $1) }'		>> ~/.extrc
echo 'alias dl="/mnt/d/Downloads/"'		>> ~/.extrc
echo 'alias prgm="/mnt/d/Programs/"'		>> ~/.extrc
echo 'alias open="explorer.exe"'		>> ~/.extrc
echo 'export PATH="$PATH:$BINDIR"'	>> ~/.extrc

echo "Exec :PlugInstall in neovim to install plugins"
exec zsh
