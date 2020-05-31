# Windows

## wsl

Put some aliases in `~/.extrc`
```bash
alias srp="cd /mnt/c/Users/Adrien/source/repos/Graphics/com.unity.render-pipelines.high-definition"
alias ecs="cd /mnt/d/Programs/C++/ECS"
srp
```

### nvim

Download a [binary release](https://github.com/neovim/neovim/releases/)
Install [win32yank](https://github.com/equalsraf/win32yank/releases) for clipboard support

# Arch

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
