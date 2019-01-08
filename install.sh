read -p "Install essentials ? " yn
case $yn in
	[Yy]* )
	sudo apt-get install build-essential make git screen
	;;
esac

read -p "Install vim ? " yn
case $yn in
[Yy]* )
	sudo apt-get install vim

	cat >> ~/.vimrc < vimrc
	;;
esac

read -p "Install Node ? " yn
case $yn in
	[Yy]* )
	sudo apt-get install nodejs npm
	;;
esac

read -p "Install zsh ? " yn
case $yn in
	[Yy]* )
	sudo apt-get install zsh curl
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";

	cat >> ~/.zshrc < zshrc
	;;
esac
