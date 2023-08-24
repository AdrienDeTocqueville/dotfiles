#!/bin/zsh

ARCH="off"
WSL="off"
MAC="off"

if [[ ! -f /proc/version ]]; then
    MAC="on"
    SYSTEM="MAC"
    if ! type brew > /dev/null ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install dialog
    alias pacinstall="brew install"
    alias whiptail=dialog
else
    PROC=$(cat /proc/version)
    if [[ $PROC =~ "arch" ]]; then
        SYSTEM="ARCH"
        ARCH=on
        alias pacinstall="sudo pacman -S"
    fi
    if [[ $PROC =~ "Microsoft" ]]; then
        SYSTEM="WSL"
        WSL=on
        alias pacinstall="sudo apt install -y"
        sudo apt update && sudo apt upgrade -y
        sudo apt autoremove -y
    fi
fi

LBL_OMZ="Install oh my zsh and vim"
LBL_ARCH="Setup for Arch"
LBL_WSL="Setup for WSL"
LBL_MAC="Setup for Mac"

SELECTION=$(whiptail --noitem --separate-output \
    --title "Setup system config" \
    --checklist "Select what to setup" 14 60 6 \
    $LBL_OMZ on $LBL_ARCH $ARCH $LBL_WSL $WSL $LBL_MAC $MAC \
    3>&1 1>&2 2>&3)

if [[ $SELECTION =~ $LBL_OMZ ]]; then
    echo "\n== Installing common packages =="
    pacinstall wget neovim ctags

    # oh my zsh
    echo "\n== Installing oh my zsh =="
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    RUNZSH="no" sh install.sh --keep-zshrc
    rm install.sh

    # vim-plug
    echo "\n== Installing Vim Plug =="
    ## for neovim and vim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ## exec pluginstall
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall
fi

if [[ $SELECTION =~ $LBL_ARCH ]]; then
    source ~/dotfiles/scripts/arch.sh
fi
if [[ $SELECTION =~ $LBL_WSL ]]; then
    source ~/dotfiles/scripts/wsl.sh
fi
if [[ $SELECTION =~ $LBL_MAC ]]; then
    source ~/dotfiles/scripts/mac.sh
fi
