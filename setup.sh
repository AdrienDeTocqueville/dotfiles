#!/bin/zsh

PROC=$(cat /proc/version)

ARCH="off"
WSL="off"

if [[ $PROC =~ "arch" ]]; then
	SYSTEM="ARCH"
	ARCH=on
	alias pacinstall sudo pacman -S
fi
if [[ $PROC =~ "Microsoft" ]]; then
	SYSTEM="WSL"
	WSL=on
	alias pacinstall sudo apt install
	sudo apt update && sudo apt upgrade -y
fi

LBL_OMZ="Install oh my zsh and vim"
LBL_ARCH="Setup for Arch"
LBL_WSL="Setup for WSL"

SELECTION=$(whiptail --noitem --separate-output \
	--title "Setup system config" \
	--checklist "Select what to setup" 14 60 6 \
	$LBL_OMZ on $LBL_ARCH $ARCH $LBL_WSL $WSL \
	3>&1 1>&2 2>&3)

if [[ $SELECTION =~ $LBL_OMZ ]]; then
	pacinstall curl neovim ctags

	# oh my zsh
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

	# vim-plug
	## Neovim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	## Vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ $SELECTION =~ $LBL_ARCH ]]; then
	source ~/dotfiles/scripts/arch.sh
fi
if [[ $SELECTION =~ $LBL_WSL ]]; then
	source ~/dotfiles/scripts/wsl.sh
fi
