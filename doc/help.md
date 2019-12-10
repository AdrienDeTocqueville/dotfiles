# Useful commands

# pacman

Delete unused packages
```
pacman -R `pacman -Qdtq`
```

Update packages
```
pacman -Syu
```

Check if package is installed
```
pacman -Qi <pkg>
```

## i3
`xprop | grep Class` : Second string

## Screen capture

```deepin-screenshot```
```byzanz out.gif```

## CMake
```bash
mkdir bin
cd bin
cmake -G "Unix Makefiles" ..
```

## Connect WPA Eduroam

```bash
systemctl stop wpa_supplicant@wlp62s0.service
wpa_supplicant -B -i wlp62s0 -c /etc/wpa_supplicant/wpa_supplicant_eduroam.conf
dhcpcd
```
Then wait a bit
