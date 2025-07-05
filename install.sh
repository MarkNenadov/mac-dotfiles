#!/bin/zsh

set -e

DRY_RUN=false
QUIET=false

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
		--quiet)
			QUIET=true
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
			if [[ "$QUIET" == "true" ]]; then
				HOMEBREW_NO_AUTO_UPDATE=1 brew bundle --quiet 2>/dev/null
				brew_result=$?
			else
				HOMEBREW_NO_AUTO_UPDATE=1 brew bundle
				brew_result=$?
			fi
			
			# Check for specific known issues and continue
			if [[ $brew_result -eq 0 ]]; then
				echo "[mac-dotfiles] All dependencies installed"
			else
				echo "[mac-dotfiles] Warning: Some Homebrew dependencies failed to install"
				echo "[mac-dotfiles] This is usually due to version conflicts with existing apps"
				echo "[mac-dotfiles] Continuing with installation..."
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
		# Handle gitconfig
		if [[ -e "$HOME/.gitconfig" && ! -L "$HOME/.gitconfig" ]]; then
			mv "$HOME/.gitconfig" "$HOME/.gitconfigOLD"
		fi
		ln -sf "$(pwd)/gitconfig" "$HOME/.gitconfig"

		# Handle zshrc
		if [[ -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
			mv "$HOME/.zshrc" "$HOME/.zshrcOLD"
		fi
		ln -sf "$(pwd)/zshrc" "$HOME/.zshrc"

		# Handle zsh directory
		if [[ -e "$HOME/.zsh" && ! -L "$HOME/.zsh" ]]; then
			mv "$HOME/.zsh" "$HOME/.zshOLD"
		fi
		ln -sf "$(pwd)/zsh" "$HOME/.zsh"

		# Handle vimrc
		if [[ -e "$HOME/.vimrc" && ! -L "$HOME/.vimrc" ]]; then
			mv "$HOME/.vimrc" "$HOME/.vimrcOLD"
		fi
		ln -sf "$(pwd)/vimrc" "$HOME/.vimrc"
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
