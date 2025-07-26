#!/bin/zsh

set -e

DRY_RUN=false
QUIET=false
INJECT_ALIASES=""

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
		--inject-aliases)
			INJECT_ALIASES="$2"
			if [[ -z "$INJECT_ALIASES" ]]; then
				echo "Error: --inject-aliases requires a target file path"
				exit 1
			fi
			shift 2
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

inject_aliases() {
	if [[ -n "$INJECT_ALIASES" ]]; then
		if [[ "$DRY_RUN" == "true" ]]; then
			echo "[mac-dotfiles] [DRY RUN] Would inject aliases from zsh/aliases.zsh to $INJECT_ALIASES"
		else
			echo "[mac-dotfiles] Injecting aliases to $INJECT_ALIASES..."
			
			# Create target file if it doesn't exist
			if [[ ! -f "$INJECT_ALIASES" ]]; then
				touch "$INJECT_ALIASES"
			fi
			
			# Add injection header
			echo "" >> "$INJECT_ALIASES"
			echo "# ==== mac-dotfiles aliases injection $(date) ====" >> "$INJECT_ALIASES"
			echo "" >> "$INJECT_ALIASES"
			
			# Inject content from aliases.zsh only
			if [[ -f "zsh/aliases.zsh" ]]; then
				echo "# From zsh/aliases.zsh" >> "$INJECT_ALIASES"
				cat "zsh/aliases.zsh" >> "$INJECT_ALIASES"
				echo "" >> "$INJECT_ALIASES"
			else
				echo "[mac-dotfiles] Warning: zsh/aliases.zsh not found"
			fi
			
			echo "# ==== End mac-dotfiles injection ====" >> "$INJECT_ALIASES"
			echo "[mac-dotfiles] Aliases injected successfully to $INJECT_ALIASES"
		fi
		return
	fi
}

inject_aliases
if [[ -n "$INJECT_ALIASES" ]]; then
	exit 0
fi

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
		ln -sfn "$(pwd)/zsh" "$HOME/.zsh"

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

isntall_language_runtimes() {
	if [[ "$DRY_RUN" == "true" ]]; then
		echo "[mac-dotfiles] [DRY RUN] Would be installing python, ruby, and java with mise"
	else
		echo "[mac-dotfiles] Installing python, ruby, and java with mise"
		mise install python@latest
		mise install ruby@latest
		mise install java@zulu-24.32.13.0

		mise use -g python@latest ruby@latest java@zulu-24.32.13.0
	fi
}
isntall_language_runtimes

install_python_dependencies() {
	if [[ "$DRY_RUN" == "true" ]]; then
		echo "[mac-dotfiles] [DRY RUN] Would install Python dependencies from python-requirements.txt"
	else
		echo "[mac-dotfiles] Installing python dependencies from python-requirements.txt"
		pip install --upgrade pip
	python3 -m pip install -r python-requirements.txt
fi
}
install_python_dependencies

if [[ "$DRY_RUN" == "true" ]]; then
	echo "[mac-dotfiles] [DRY RUN] Installation simulation complete. No changes were made."
else
	echo "[mac-dotfiles] Finished."
fi
