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
mkdir $BINDIR
fi

APPDATA=$(echo "$PATH" | grep -o "[^:]*Microsoft/WindowsApps*")
APPDATA="$APPDATA/../.."

echo "BINDIR=" $BINDIR
echo "APPDATA=" $APPDATA

if [[ $SELECTION =~ $EXTRC ]]; then
	echo "\n== Creating ~/.extrc config =="
	cat <<- END > ~/.extrc
		vim() { ~/.nvim/bin/nvim -O \$* }
		goto() { cd \$(wslpath \$1) }
		alias dl="/mnt/d/Downloads/"
		alias prgm="/mnt/d/Programs/"
		alias open="explorer.exe"
		alias dot="cd ~/dotfiles"
		alias doc="vim ~/dotfiles/doc/setup.md"
		
		alias rp="cd /mnt/; vim"

		export PATH="\$PATH:$BINDIR"
		export SYSTEM=$SYSTEM
	END
fi

if [[ $SELECTION =~ $STDPAC ]]; then
	echo "\n== Installing common packages =="
	sudo apt install -y unzip silversearcher-ag
fi

if [[ $SELECTION =~ $CFG ]]; then
	echo "\n== Setting up config =="

	~/dotfiles/scripts/setup_symlinks.sh
	\cp ~/dotfiles/config/settings.json $APPDATA/Packages/Microsoft.WindowsTerminal*/LocalState
	\cp ~/dotfiles/config/bashrc $(wslpath "$(wslvar USERPROFILE)")/.bashrc

	#curl -fLo /tmp/FiraCode.zip https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip
	#unzip /tmp/FiraCode.zip -d /tmp/FiraCode
	#mkdir $APPDATA/Temp/ttf
	#mv /tmp/FiraCode/ttf/FiraCode-Regular.ttf $APPDATA/Temp/ttf
	#explorer.exe $(wslpath -w $APPDATA/Temp/ttf)
fi

if [[ $SELECTION =~ $NEOVIM ]]; then
	echo "\n== Installing Neovim =="

	curl -fLo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
	tar xzf /tmp/nvim.tar.gz -C /tmp
	mv /tmp/nvim-linux64 ~/.nvim

	# Vi bindings
	#git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode

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

echo "\nInstallation complete, please restart your shell"
