# Windows

Exec `wsl.sh`

# Arch

Exec `arch.sh`

Note: Core dumps are located in `/var/lib/systemd/coredump/`

## General purpose packages

Pacman:
 * alacritty rofi
 * yay
 * xorg-xinput xorg-xprop xorg-xev
 * alsa-utils alsa-oss
 * feh (for wallpaper)

AUR:
 * betterlockscreen
 * polybar
 * apvlv (pdf)

WiFi:
 * nmtui
 * networkmanager
 * wpa_supplicant

## pacman

Delete unused packages
```bash
pacman -R `pacman -Qdtq`
```

Update packages
```bash
pacman -Syu
```

Check if package is installed
```bash
pacman -Qi <pkg>
```

## i3
```
xprop | grep Class # Use the second string
```

### Multi monitors
xrandr --query | grep " connected"
Init second monitor as extend (default is duplicate)
```
xrandr --output HDMI2 --auto --above eDP1
```

## Screen capture

```bash
deepin-screenshot
byzanz out.gif
```

## CMake

```bash
mkdir bin
cd bin
cmake -G "Unix Makefiles" ..
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
