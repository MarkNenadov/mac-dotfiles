#!/bin/zsh

set -e

DRY_RUN=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
		--dry-run)
			DRY_RUN=true
			shift
			;;
		--skip-brew)
			SKIP_BREW=true
			shift
			;;
		*)
			echo "Unknown option: $1"
			exit 1
			;;
	esac
done

do_brew() {
	if [[ "$SKIP_BREW" != "true" ]]; then
		if [ ! $(which brew) ]; then
			if [[ "$DRY_RUN" == "true" ]]; then
				echo "[mac-dotfiles] [DRY RUN] Would install Homebrew..."
			else
				echo "[mac-dotfiles] Installing homebrew..."
				/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
				echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
				eval "$(/opt/homebrew/bin/brew shellenv)"
			fi
		fi

		if [[ "$DRY_RUN" == "true" ]]; then
			echo "[mac-dotfiles] [DRY RUN] Would install Homebrew dependencies..."
		else
			echo "[mac-dotfiles] Installing dependencies via Homebrew..."
			brew tap anchore/grype
			if brew bundle; then
				echo "[mac-dotfiles] All dependencies installed"
			else
				echo "[mac-dotfiles] Error: Failed to install Homebrew dependencies"
			fi
		fi
	fi
}
do_brew

echo "[mac-dotfiles] Linking dotfiles..."

link_dotfiles() {
	if [[ "$DRY_RUN" == "true" ]]; then
		echo "[mac-dotfiles] [DRY RUN] Would link:"
		echo "  - gitconfig -> $HOME/.gitconfig"
		echo "  - zshrc -> $HOME/.zshrc"
		echo "  - zsh/ -> $HOME/.zsh"
		echo "  - vimrc -> $HOME/.vimrc"
	else
		mv "$HOME/.gitconfig" "$HOME/.gitconfigOLD"
		ln -s "$(pwd)/gitconfig" "$HOME/.gitconfig"

		mv "$HOME/.zshrc" "$HOME/.zshrcOLD"
		ln -s $(pwd)/zshrc $HOME/.zshrc

		mv "$HOME/.zsh" "$HOME/.zshOLD"
		ln -s $(pwd)/zsh $HOME/.zsh	

		if [[ -e "$HOME/.vimrc" ]]; then
			mv "$HOME/.vimrc" "$HOME/.vimrcOLD"
		fi
		ln -s "$(pwd)/vimrc" "$HOME/.vimrc"
	fi
}
link_dotfiles

echo "[mac-dotfiles] Installing zshlilly in $HOME"

install_zshlilly() {
	if [[ "$DRY_RUN" == "true" ]]; then
		echo "[mac-dotfiles] [DRY RUN] Would install zshlilly"
	else
		git clone https://github.com/MarkNenadov/zshlilly.git
		cd zshlilly
		./install.zsh $HOME
		cd ..
		rm -rf zshlilly
	fi
}
install_zshlilly

echo "[mac-dotfiles] Installing latest python"

install_latest_python() {
	if [[ "$DRY_RUN" == "true" ]]; then
		echo "[mac-dotfiles] [DRY RUN] Would install latest Python version"
	else
		latest_version=$(pyenv install --list | grep -v - | grep -v b | tail -1)
		pyenv install $latest_version
		pyenv global $latest_version
	fi
}
install_latest_python || echo "[mac-dotfiles] failed installing python"

echo "[mac-dotfiles] Installing python dependencies"

if [[ "$DRY_RUN" == "true" ]]; then
	echo "[mac-dotfiles] [DRY RUN] Would install Python dependencies from python-requirements.txt"
else
	python3 -m pip install -r python-requirements.txt
fi

if [[ "$DRY_RUN" == "true" ]]; then
	echo "[mac-dotfiles] [DRY RUN] Installation simulation complete. No changes were made."
else
	echo "[mac-dotfiles] Finished."
fi
