#!/bin/zsh
#
# Arguments to setup in Unity preferences
# -p $(ProjectPath) -f $(File) -l $(Line)
#

XX=$(python3 $HOME/dotfiles/scripts/unity_open.py $*)


STR='tell app "Terminal" to do script "'$XX'; pkill -a Terminal"'
echo $STR

osascript -e $STR

