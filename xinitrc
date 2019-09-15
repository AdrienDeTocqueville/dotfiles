setxkbmap fr
xmodmap .Xmodmap

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exec i3
