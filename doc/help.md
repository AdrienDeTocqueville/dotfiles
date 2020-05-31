# Useful commands

## Wifi

As root

```bash
wpa_passphrase <ssid> <pwd> > /etc/wpa_supplicant/wpa_supplicant-wlp62s0.conf
```

Reload

```bash
systemctl stop wpa_supplicant@wlp62s0.service
wpa_supplicant -B -i wlp62s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp62s0.conf
dhcpcd
```
Then wait a bit

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
`xprop | grep Class` : Second string

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
