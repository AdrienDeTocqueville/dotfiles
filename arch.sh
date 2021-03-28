#!/bin/zsh

echo 'vim() { nvim -O $* }'	>> ~/.extrc
echo 'alias df="df -h | grep -e sda6 -e Used"'		>> ~/.extrc
echo 'alias run="make -j$(nproc) run"'  >> ~/.extrc
echo 'alias dl="cd $HOME/downloads"'    >> ~/.extrc
echo 'alias dot="cd $HOME/dotfiles"'    >> ~/.extrc
echo 'alias prgm="cd $HOME/repos"'  >> ~/.extrc
echo 'alias pacman="sudo pacman"'   >> ~/.extrc
echo 'alias mount="sudo mount"' >> ~/.extrc
echo 'alias mnt="sudo mnt"' >> ~/.extrc
echo 'alias umount="sudo umount"'   >> ~/.extrc
echo 'alias pdf="apvlv"'    >> ~/.extrc
echo 'alias wifi="nmtui-connect"'   >> ~/.extrc
echo ""
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib'   >> ~/.extrc
echo 'export PATH=$PATH:$HOME/bin'  >> ~/.extrc
