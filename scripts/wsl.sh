#!/bin/zsh

EXTRC="Fill .extrc"
CFG="Setup config files"
GIT="Replace git package"
STDPAC="Install standard packages"
NEOVIM="Install neovim"
CLIPBOARD="Install neovim clipboard support"

SELECTION=$(whiptail --noitem --separate-output \
	--title "Setup WSL config" \
	--checklist "Select what to setup" 14 60 6 \
	$EXTRC on $CFG on $STDPAC on $NEOVIM on $CLIPBOARD on $GIT off\
	3>&1 1>&2 2>&3)

echo "\n== Detecting config =="

if [ -d "/mnt/d/Softwares" ] ; then
BINDIR="/mnt/d/Softwares"
else
BINDIR="/mnt/c/Softwares"
fi

APPDATA=$(echo "$PATH" | grep -o "[^:]*Microsoft/WindowsApps*")

echo "BINDIR=" $BINDIR
echo "APPDATA=" $APPDATA

if [[ $SELECTION =~ $EXTRC ]]; then
	echo "\n== Creating ~/.extrc config =="
	cat <<- END > ~/.extrc
		vim() { ~/nvim/usr/bin/nvim -O $* }
		goto() { cd $(wslpath $1) }
		alias dl="/mnt/d/Downloads/"
		alias prgm="/mnt/d/Programs/"
		alias open="explorer.exe"
		alias doc="vim ~/dotfiles/doc/setup.md"

		export PATH="$PATH:$BINDIR"
		export SYSTEM=$SYSTEM
	END
fi

if [[ $SELECTION =~ $CFG ]]; then
	echo "\n== Setting up symlinks =="

	~/dotfiles/scripts/setup_symlinks.sh
	\cp ~/dotfiles/config/settings.json $APPDATA/../../Packages/Microsoft.WindowsTerminal*/LocalState
fi

if [[ $SELECTION =~ $STDPAC ]]; then
	echo "\n== Installing common packages =="
	sudo apt install -y unzip silversearcher-ag
fi

if [[ $SELECTION =~ $NEOVIM ]]; then
	echo "\n== Installing Neovim =="

	mkdir ~/nvim
	curl -fLo ~/nvim/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
	chmod u+x ~/nvim/nvim.appimage
	~/nvim/nvim.appimage --appimage-extract
	mv squashfs-root/* ~/nvim
	rm -rf squashfs-root

	#echo "\n\n\n\nExec :PlugInstall in neovim to install plugins"
	#exec zsh
fi

if [[ $SELECTION =~ $CLIPBOARD ]]; then
	echo "\n== Installing clipboard support for nvim =="

	mkdir ~/win32yank
	curl -fLo ~/win32yank/yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x86.zip
	unzip ~/win32yank/yank.zip -d ~/win32yank
	mv ~/win32yank/win32yank.exe "$BINDIR" && rm -rf ~/win32yank
fi

if [[ $SELECTION =~ $GIT ]]; then
	echo "\n== Replacing git package =="
	echo "WIP..."
	if [ -d $BINDIR/Git/bin/git.exe ] ; then
		echo "Detected git for windows"
		sudo ln -s $BINDIR/Git/bin/git.exe  /bin/git
	fi
fi
