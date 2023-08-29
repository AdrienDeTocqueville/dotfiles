#!/bin/zsh

EXTRC="Fill .extrc"
STDPAC="Install standard packages"
ALLPAC="Install advanced packages"
CFG="Setup config files"

SELECTION=$(dialog --noitem --separate-output \
    --title "Setup Mac config" \
    --checklist "Select what to setup" 14 60 8 \
    $EXTRC on $STDPAC off $ALLPAC off $CFG off\
    3>&1 1>&2 2>&3)
clear

if [[ $SELECTION =~ $EXTRC ]]; then
    echo "\n== Creating ~/.extrc config =="

    echo "vim() { nvim -O \$* }" > ~/.extrc
    echo "alias rp='cd /mnt/; vim'" >> ~/.extrc
    echo "export SYSTEM=$SYSTEM" >> ~/.extrc
fi

if [[ $SELECTION =~ $STDPAC ]]; then
    echo "\n== Installing standard packages =="
    brew install ripgrep python3
fi

if [[ $SELECTION =~ $ALLPAC ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [[ $SELECTION =~ $CFG ]]; then
    echo "\n== Setting up config =="

    ~/dotfiles/scripts/setup_symlinks.sh
fi

echo "\nInstallation complete, please restart your shell"
