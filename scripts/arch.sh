#!/bin/zsh

EXTRC="Fill .extrc"
STDPAC="Install standard packages"
ALLPAC="Install advanced packages"
I3PAC="Install i3 environnement"
BIN="Install custom binaries"
CFG="Setup config files"
ROOT="Setup for root user"

SELECTION=$(whiptail --noitem --separate-output \
	--title "Setup Arch config" \
	--checklist "Select what to setup" 14 60 8 \
	$EXTRC on $STDPAC off $ALLPAC off $I3PAC off $BIN off $CFG off $ROOT off\
	3>&1 1>&2 2>&3)


if [[ $SELECTION =~ $CFG || $SELECTION =~ $ROOT ]]; then
	if [[ "$EUID" != 0 ]] ; then
		echo "You need to be root user for this"
		exit 1
	fi
fi

if [[ $SELECTION =~ $EXTRC ]]; then
	echo "\n== Creating ~/.extrc config =="

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
		export SYSTEM=$SYSTEM
	END
fi

if [[ $SELECTION =~ $STDPAC ]]; then
	echo "\n== Installing standard packages =="
	sudo pacman -S the_silver_searcher
	sudo pacman -S numlockx wpa_supplicant nmtui
fi

if [[ $SELECTION =~ $ALLPAC ]]; then
	echo "\n== Installing advanced packages =="

	sudo pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rm -rf yay

	sudo pacman -S alsa-utils alsa-oss
fi

if [[ $SELECTION =~ $I3PAC ]]; then
	echo "\n== Installing i3 environnement =="

	sudo yay -S apvlv polybar
	sudo pacman -S alacritty rofi
	sudo pacman -S feh unclutter betterlockscreen xorg-xbacklight
	sudo pacman -S i3-wm xorg-server xorg-xinput xorg-xprop xorg-xev
fi

if [[ $SELECTION =~ $BIN ]]; then
	echo "\n== Installing custom binaries =="
	function rootsymlink() {
		sudo test -f /usr/local/bin/$1 && sudo ln -s ~/dotfiles/$1 /usr/local/bin/$1 && chmod +x /usr/local/bin/$1
		#&& chown root /usr/local/bin/$1
	}

	rootsymlink "sensitivity"
fi

if [[ $SELECTION =~ $CFG ]]; then
	echo "\n== Setting up config =="

	# keyboard
	cp ~/.config/xorg/custom.map /usr/share/kbd/keymaps/
	echo KEYMAP=custom >> /etc/vconsole.conf
	ln -s ~/.config/xorg/xorg.conf /etc/X11/xorg.conf
	ln -s ~/dotfiles/config/xorg/40-libinput.conf /usr/share/X11/xorg.conf.d/40-libinput.conf

	# clock
	systemctl start systemd-timesyncd.service
	cat <<- END > /etc/systemd/timesyncd.conf
		[Time]
		NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
		FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org
	END
	timedatectl set-ntp true

	~/dotfiles/scripts/setup_symlinks.sh

	rm ~/.elinks
	rm ~/.screenrc

	ln -s ~/dotfiles/config/elinks ~/.elinks
	ln -s ~/dotfiles/config/screenrc ~/.screenrc

	rm -f ~/.config/i3
	rm -f ~/.config/xorg
	rm -f ~/.config/polybar

	ln -s ~/dotfiles/config/i3	~/.config/i3
	ln -s ~/dotfiles/config/xorg	~/.config/xorg
	ln -s ~/dotfiles/config/polybar	~/.config/polybar
fi

if [[ $SELECTION =~ $ROOT ]]; then
	echo "\n== Setting up root user config =="

	sudo chown -R root:root $ZSH

	sudo mkdir -p /root/.config
	sudo mkdir -p /root/.local/share
	sudo ln -s ~/dotfiles /root/dotfiles
	sudo rm -rf /root/.vim /root/.config /root/.zshrc /root/.vimrc /root/.local/share/nvim
	sudo ln -s ~/.vim	/root/.vim
	sudo ln -s ~/.config	/root/.config
	sudo ln -s ~/.local/share/nvim	/root/.local/share
	sudo ln -s ~/dotfiles/config/zshrc		/root/.zshrc
	sudo ln -s ~/dotfiles/config/nvim/init.vim	/root/.vimrc
fi
