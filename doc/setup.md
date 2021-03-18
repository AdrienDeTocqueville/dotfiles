# Windows

Exec `wsl.sh`

# Arch

## extrc

```bach
vim() { nvim -O $* }
alias df="df -h | grep -e sda6 -e Used"
alias dl="cd $HOME/downloads"
alias prgm="cd $HOME/repos"
alias pdf="apvlv"
alias wifi="nmtui-connect"
alias pacman="sudo pacman"
alias mount="sudo mount"
alias mnt="sudo mnt"
alias umount="sudo umount"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export PATH=$PATH:$HOME/bin
```

## General purpose packages

Pacman:
 * alacritty rofi
 * yay
 * xorg-xinput xorg-xprop xorg-xev
 * alsa-utils alsa-oss

AUR:
 * betterlockscreen
 * polybar
 * apvlv (pdf)

## WIFI

 * networkmanager
 * wpa_supplicant

## Wallpaper

```bash
pacman -S feh
```

In `~/.fehbg`:
```bash
#!/bin/sh
feh --no-fehbg --bg-scale '$HOME/Pictures/wallpaper.png'
```

## Bluetooth

### Install
```bash
pacman -S bluez bluez-utils
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```

### Connect
```bash
bluetoothctl
> power on
> agent on
> scan on
 * wait for device *
> pair <MAC>
> trust <MAC>
> connect <MAC>
```

## Opera

Extensions:
 * Privacy Badger
 * uBlock Origin
 * Vimium

### Vimium
Excluded:
`https?://www.youtube.com/watch*` - `fjklm`

Custom mappings:
`map <c-d> scrollPageDown`
