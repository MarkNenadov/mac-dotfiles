#!/bin/zsh

set -e

do_brew() {
	if [ ! $(which brew) ]; then
  		echo "[mac-dotfiles] Installing homebrew..."
  		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	echo "[mac-dotfiles] Installing dependencies via Homebrew..."
	if brew bundle; then
  		echo "[mac-dotfiles] All dependencies installed"
        else
		echo "[mac-dotfiles] Error: Failed to install Homebrew dependencies"
	fi
}
do_brew

echo "[mac-dotfiles] Linking dotfiles..."

link_dotfiles() {
	mv $HOME/.gitconfig $HOME/.gitconfigOLD
	ln -s $(pwd)/gitconfig $HOME/.gitconfig

	mv $HOME/.zshrc $HOME/.zshrcOLD
	ln -s $(pwd)/zshrc $HOME/.zshrc

	if [[ -e $HOME/.vimrc ]]; then
		mv $HOME/.vimrc $HOME/.vimrcOLD
	fi
	ln -s $(pwd)/vimrc $HOME/.vimrc
}
link_dotfiles

echo "[mac-dotfiles] Installing zshlilly in $HOME"

install_zshlilly() {
	git clone https://github.com/MarkNenadov/zshlilly.git
	cd zshlilly
	./install.zsh $HOME
	cd ..
	rm -rf zshlilly
}
install_zshlilly

echo "[mac-dotfiles] Installing latest python"

install_latest_python() {
	latest_version=$(pyenv install --list | grep -v - | grep -v b | tail -1)
	pyenv install $latest_version
	pyenv global $latest_version
}
install_latest_python
