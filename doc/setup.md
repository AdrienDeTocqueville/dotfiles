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
