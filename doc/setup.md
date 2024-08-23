# Windows

Exec `wsl.sh`

# Mac

```bash
defaults write com.apple.dock "autohide-time-modifier" -float "0" && killall Dock
defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder
```

# Arch

Exec `arch.sh`

## sudo

```bash
pacman -S sudo
visudo
> root ALL=(ALL) ALL
> %wheel ALL=(ALL) ALL
> Defaults rootpw
```

## Groups group

list groups: `getent group`
list groups of current user: `groups`
create group: `groupadd wheel`

## Create user

```bash
useradd otarie --create-home
passwd otarie
sudo usermod -a -G wheel otarie
```

## Auto mount drive

Add line in /etc/fstab
```
UUID=8C86DCCF86DCBAC2	/data	auto	nosuid,nodev,nofail,fmask=0022,dmask=0022	0 0
```

## Infos

Core dumps are located in `/var/lib/systemd/coredump/`

#### Fonts
- FiraCode / FiraMono (nerd-fonts-fira-mono on aur)
- gucharmap or this https://github.com/wstam88/rofi-fontawesome to browse font characters

## General purpose packages

Pacman:
 * alacritty rofi
 * yay
 * xorg-xinput xorg-xprop xorg-xev
 * alsa-utils alsa-oss
 * feh (for wallpaper)
 * unclutter
 * numlockx
 * gucharmap
 * xbacklight

AUR:
 * betterlockscreen
 * polybar
 * apvlv (pdf)

WiFi:
 * nmtui
 * networkmanager
 * wpa_supplicant

## Fonts
- FiraCode / FiraMono: `yay -S nerd-fonts-fira-mono`
- `pacman -S ttf-nerd-fonts-symbol`
- gucharmap or this https://github.com/wstam88/rofi-fontawesome to browse font characters

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

### Orientation

xrandr --orientation 1

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

# Browser

## Extensions

 * Privacy Badger
 * uBlock Origin
 * Vimium
 * RSS Feed Reeder

## Vimium
Excluded:
`https?://www.youtube.com/watch*` - `fjklm`
`https?://github.cds.internal.unity3d.com/*` - `b`

Custom mappings:
`map <c-d> scrollPageDown`

## Vivaldi

See `profile path` at [vivaldi://about/]()

Toolbar settings are in preferences file:
```
"web":{"elements":[{"activeUrl":"https://www.wikipedia.org/","faviconUrl":"https://www.wikipedia.org/","faviconUrlValid":true,"id":"WEBPANEL_ckn7fhhqx0000hc2roo8jshm4","mobileMode":true,"title":"Wikipedia","url":"https://wikipedia.org","zoom":1},{"activeUrl":"https://web.whatsapp.com/","faviconUrl":"https://web.whatsapp.com/","faviconUrlValid":true,"id":"WEBPANEL_bfcb0f5f-2449-4342-8e5b-4973fa45a6a3","mobileMode":false,"origin":"user","resizable":false,"title":"WhatsApp","url":"https://web.whatsapp.com/","width":816,"zoom":1},{"activeUrl":"https://www.deezer.com/fr/","faviconUrl":"https://www.deezer.com/fr/","faviconUrlValid":true,"id":"WEBPANEL_f00992bf-f6a4-4e03-b7f6-fecbf088415e","mobileMode":false,"origin":"user","resizable":false,"title":"Deezer - Flow - Télécharge & Écoute ta Musique | Streaming Gratuit","url":"http://deezer.com/","width":493.164,"zoom":1},{"activeUrl":"https://www.deepl.com/en/translator#fr/en-us/couette%20et%20oreiller","faviconUrl":"https://www.deepl.com/en/translator#fr/en-us/couette%20et%20oreiller","faviconUrlValid":true,"id":"WEBPANEL_0b5a40e2-47e9-48bd-8bc3-1edb3c6db789","mobileMode":false,"origin":"user","resizable":false,"title":"DeepL Translate: The world's most accurate translator","url":"http://deepl.com/","width":-1,"zoom":1},{"activeUrl":"https://www.messenger.com/e2ee/t/8240661252659665/","faviconUrl":"https://www.messenger.com/e2ee/t/8240661252659665/","faviconUrlValid":true,"id":"WEBPANEL_6244f19e-cbfb-449e-af61-d53e8939dfa6","mobileMode":false,"origin":"user","resizable":false,"title":"Messenger","url":"http://messenger.com/","width":-1,"zoom":1}]

"toolbars":{"panel":["FlexibleSpacer","PanelMail","PanelCalendar","PanelTasks","PanelFeeds","PanelContacts","WEBPANEL_6244f19e-cbfb-449e-af61-d53e8939dfa6","WEBPANEL_bfcb0f5f-2449-4342-8e5b-4973fa45a6a3","WEBPANEL_0b5a40e2-47e9-48bd-8bc3-1edb3c6db789","WEBPANEL_ckn7fhhqx0000hc2roo8jshm4","WEBPANEL_f00992bf-f6a4-4e03-b7f6-fecbf088415e","PanelWeb","FlexibleSpacer","PanelNotes","PanelBookmarks","PanelHistory","PanelDownloads","PanelWindow"]}
```
