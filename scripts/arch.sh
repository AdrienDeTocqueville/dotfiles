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

if [[ $SELECTION =~ $CFG ]]; then
	echo "\n== Setting up symlinks =="

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

	sudo cp ~/.config/xorg/custom.map /usr/share/kbd/keymaps/
	sudo sh -c "echo KEYMAP=custom >> /etc/vconsole.conf"
	sudo ln -s ~/.config/xorg/xorg.conf /etc/X11/xorg.conf

	sudo chown -R root:root $ZSH

	sudo mkdir -p /root/.config
	sudo ln -s ~/dotfiles /root/dotfiles
	sudo rm -rf /root/.vim /root/.config /root/.zshrc /root/.vimrc
	sudo ln -s ~/.vim	/root/.vim
	sudo ln -s ~/.config	/root/.config
	sudo ln -s ~/dotfiles/config/zshrc		/root/.zshrc
	sudo ln -s ~/dotfiles/config/nvim/init.vim	/root/.vimrc
fi

if [[ $SELECTION =~ $STDPAC ]]; then
	echo "\n== Installing standard packages =="
	sudo pacman -S the_silver_searcher
	sudo pacman -S numlockx wpa_supplicant nmtui
fi

if [[ $SELECTION =~ $ALLPAC ]]; then
	echo "\n== Installing advanced packages =="
	
	pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si

	sudo yay -S apvlv polybar
	sudo pacman -S alacritty rofi
	sudo pacman -S feh unclutter betterlockscreen xorg-xbacklight
	#sudo pacman -S xorg-xinput xorg-xprop xorg-xev alsa-utils alsa-oss
fi

if [[ $SELECTION =~ $BIN ]]; then
	echo "\n== Installing custom binaries =="
	function rootsymlink() {
		sudo test -f /usr/local/bin/$1 && sudo ln -s ~/dotfiles/$1 /usr/local/bin/$1 && chmod +x /usr/local/bin/$1
		#&& chown root /usr/local/bin/$1
	}

	rootsymlink "sensitivity"
fi
