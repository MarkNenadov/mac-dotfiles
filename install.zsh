#!/bin/zsh

set -e

readonly HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
readonly ZSHLILLY_REPO_URL="https://github.com/MarkNenadov/zshlilly.git"
readonly MISE_JAVA_VERSION="zulu-24.32.13.0"

# Logging helper functions
log() {
	echo "[mac-dotfiles] $1"
}

log_dry_run() {
	echo "[mac-dotfiles] [DRY RUN] $1"
}

# Backup existing file and create symlink
backup_and_link() {
	local source_file="$1"
	local target_path="$2"
	local is_directory="${3:-false}"
	
	if [[ -e "$target_path" && ! -L "$target_path" ]]; then
		mv "$target_path" "${target_path}OLD"
	fi
	
	if [[ "$is_directory" == "true" ]]; then
		ln -sfn "$source_file" "$target_path"
	else
		ln -sf "$source_file" "$target_path"
	fi
}

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
				log_dry_run "Would install Homebrew..."
			else
				log "Installing homebrew..."
				/usr/bin/ruby -e "$(curl -fsSL $HOMEBREW_INSTALL_URL)"
				echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
				eval "$(/opt/homebrew/bin/brew shellenv)"
			fi
		fi

		if [[ "$DRY_RUN" == "true" ]]; then
			log_dry_run "Would install Homebrew dependencies..."
		else
			log "Installing dependencies via Homebrew..."
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
				log "All dependencies installed"
			else
				log "Warning: Some Homebrew dependencies failed to install"
				log "This is usually due to version conflicts with existing apps"
				log "Continuing with installation..."
			fi
		fi
	fi
}

# Load the inject-aliases library
source "$(pwd)/zsh/lib/inject-aliases.zsh"

handle_inject_aliases() {
	if [[ -n "$INJECT_ALIASES" ]]; then
		inject_aliases "$INJECT_ALIASES" "$DRY_RUN"
		return $?
	fi
}

handle_inject_aliases
if [[ -n "$INJECT_ALIASES" ]]; then
	exit 0
fi

do_brew

if [[ "$DRY_RUN" == "true" ]]; then
    log_dry_run "Would be installing vs code extensions from vscode/extensions.txt"
else
    log "Installing vs code extensions from vscode/extensions.txt"
    cat vscode/extensions.txt | xargs -n 1 code --install-extension >/dev/null 2>&1
fi

if [[ "$DRY_RUN" == "true" ]]; then
    log_dry_run "Would be installing cursor extensions from cursor/extensions.txt"
else
    log "Installing cursor extensions from cursor/extensions.txt"
    cat cursor/extensions.txt | xargs -n 1 cursor --install-extension >/dev/null 2>&1
fi


log "Linking dotfiles..."

link_dotfiles() {
	if [[ "$DRY_RUN" == "true" ]]; then
		log_dry_run "Would link:"
		echo "  - gitconfig -> $HOME/.gitconfig"
		echo "  - zshrc -> $HOME/.zshrc"
		echo "  - zsh/ -> $HOME/.zsh"
		echo "  - vimrc -> $HOME/.vimrc"
		echo "  - vscode/settings.json -> $HOME/Library/Application Support/Code/User/settings.json"
		echo "  - cursor/settings.json -> $HOME/Library/Application Support/Cursor/User/settings.json"
	else
		# Handle gitconfig
		backup_and_link "$(pwd)/gitconfig" "$HOME/.gitconfig"

		# Handle zshrc
		backup_and_link "$(pwd)/zshrc" "$HOME/.zshrc"

		# Handle zsh directory
		backup_and_link "$(pwd)/zsh" "$HOME/.zsh" true

		# Handle zsh directory
		backup_and_link "$(pwd)/claude" "$HOME/.claude" true


		# Handle vimrc
		backup_and_link "$(pwd)/vimrc" "$HOME/.vimrc"

		# Handle VS Code settings
		mkdir -p "$HOME/Library/Application Support/Code/User"
		backup_and_link "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
		
		# Handle Cursor settings
		mkdir -p "$HOME/Library/Application Support/Cursor/User"
		backup_and_link "$(pwd)/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
	fi
}
link_dotfiles

log "Installing zshlilly in $HOME"

install_zshlilly() {
	if [[ "$DRY_RUN" == "true" ]]; then
		log_dry_run "Would install zshlilly"
	else
		git clone $ZSHLILLY_REPO_URL
		cd zshlilly
		./install.zsh $HOME
		cd ..
		rm -rf zshlilly
	fi
}
install_zshlilly

install_language_runtimes() {
	if [[ "$DRY_RUN" == "true" ]]; then
		log_dry_run "Would be installing python, ruby, and java with mise"
	else
		log "Installing python, ruby, and java with mise"
		mise install python@latest
		mise install ruby@latest
		mise install java@$MISE_JAVA_VERSION

		mise use -g python@latest ruby@latest java@$MISE_JAVA_VERSION
	fi
}
install_language_runtimes

install_python_dependencies() {
	if [[ "$DRY_RUN" == "true" ]]; then
		log_dry_run "Would install Python dependencies from python/python-requirements.txt"
	else
		log "Installing python dependencies from python/python-requirements.txt"
		pip install --upgrade pip
		python3 -m pip install -r python/python-requirements.txt
	fi
}
install_python_dependencies

if [[ "$DRY_RUN" == "true" ]]; then
	log_dry_run "Installation simulation complete. No changes were made."
else
	log "Finished."
fi
