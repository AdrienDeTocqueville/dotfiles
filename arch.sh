#!/bin/zsh

EXTRC="Fill .extrc"
CFG="Setup config files"
ROOT="Setup for root user"
STDPAC="Install standard packages"
ALLPAC="Install advanced packages"
BIN="Install custom binaries"

SELECTION=$(whiptail --noitem --separate-output \
	--title "Setup Arch config" \
	--checklist "Select what to setup" 14 60 6 \
	$EXTRC on $CFG off $ROOT off $STDPAC off $ALLPAC off $BIN off\
	3>&1 1>&2 2>&3)

grep $EXTRC <<< $SELECTION >/dev/null
if [ $? -eq 0 ]; then
	cat <<- END > ~/.extrc
		vim() { nvim -O \$* }
		alias df="df -h | grep -e sda6 -e Used"
		alias run="make -j\$(nproc) run"
		alias dl="cd \$HOME/downloads"
		alias dot="cd \$HOME/dotfiles"
		alias prgm="cd \$HOME/repos"
		alias pacman="sudo pacman"
		alias mount="sudo mount"
		alias mnt="sudo mnt"
		alias umount="sudo umount"
		alias pdf="apvlv"
		alias wifi="nmtui-connect"
		alias doc="vim ~/dotfiles/doc/setup.md"

		export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib
		export PATH=\$PATH:\$HOME/bin
	END
fi

grep $CFG <<< $SELECTION >/dev/null
if [ $? -eq 0 ]; then
	~/dotfiles/setup.sh

	ln -s ~/dotfiles/elinks ~/.elinks
	ln -s ~/dotfiles/screenrc ~/.screenrc

	ln -s ~/dotfiles/config/i3	~/.config/i3
	ln -s ~/dotfiles/config/xorg	~/.config/xorg
	ln -s ~/dotfiles/config/polybar	~/.config/polybar
fi

grep $ROOT <<< $SELECTION >/dev/null
if [ $? -eq 0 ]; then
	sudo cp ~/dotfiles/xorg/custom.map /usr/share/kbd/keymaps/
	sudo echo KEYMAP=custom >> /etc/vconsole.conf
	sudo ln -s ~/.config/xorg/xorg.conf /etc/X11/xorg.conf
fi

grep $STDPAC <<< $SELECTION >/dev/null
if [ $? -eq 0 ]; then
	sudo pacman -S alacritty rofi polybar
	#sudo pacman -S xorg-xinput xorg-xprop xorg-xev alsa-utils alsa-oss
	sudo pacman -S feh unclutter numlockx betterlockscreen xbacklight
	sudo pacman -S wpa_supplicant nmtui
fi

grep $ALLPAC <<< $SELECTION >/dev/null
if [ $? -eq 0 ]; then
	sudo pacman -S apvlv yay
fi

grep $BIN <<< $SELECTION >/dev/null
if [ $? -eq 0 ]; then
	function rootsymlink() {
		sudo test -f /usr/local/bin/$1 && sudo ln -s ~/dotfiles/$1 /usr/local/bin/$1 && chmod +x /usr/local/bin/$1
		#&& chown root /usr/local/bin/$1
	}

	rootsymlink "sensitivity"
fi
