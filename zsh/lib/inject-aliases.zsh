#!/usr/bin/env zsh

# Source centralized logging functions
source "$(dirname "$0")/logging.zsh"

# inject_aliases function - extracts aliases from zsh/aliases.zsh and injects
# them into a target file
# Usage: inject_aliases <target_file> [dry_run]
function inject_aliases() {
	local target_file="$1"
	local dry_run="${2:-false}"
	
	if [[ -z "$target_file" ]]; then
		log "Error: inject_aliases requires a target file path"
		return 1
	fi
	
	if [[ "$dry_run" == "true" ]]; then
		log_dry_run "Would inject aliases from zsh/aliases.zsh to $target_file"
		return 0
	fi
	
	log "Injecting aliases to $target_file..."
	
	# Note: We'll create the target file only if we have content to inject
	
	# Check if aliases.zsh exists
	if [[ ! -f "zsh/aliases.zsh" ]]; then
		log "Error: zsh/aliases.zsh not found"
		return 1
	fi
	
	# Parse existing aliases from target file using a temporary file
	temp_existing=$(mktemp)
	if [[ -f "$target_file" ]]; then
		grep '^alias ' "$target_file" 2>/dev/null | \
			sed 's/^alias \([^=]*\)=\(.*\)$/\1|\2/' > "$temp_existing"
	fi
	
	declare -A existing_aliases
	while IFS='|' read -r alias_name alias_def; do
		if [[ -n "$alias_name" ]]; then
			existing_aliases[$alias_name]="$alias_def"
		fi
	done < "$temp_existing"
	rm -f "$temp_existing"
	
	# Check if for loop already exists
	has_for_loop=0
	if [[ -f "$target_file" ]] && \
		grep -q 'for c in cp rm chmod chown rename; do' \
			"$target_file" 2>/dev/null; then
		has_for_loop=1
	fi
	
	# Process source file line by line
	local -a new_aliases
	local -a skipped_duplicates
	local -i conflicts=0
	local -i in_for_loop=0
	
	while IFS= read -r line; do
		if [[ $line =~ '^alias[[:space:]]+([^=]+)=(.*)$' ]]; then
			alias_name="${line#alias }"
			alias_name="${alias_name%%=*}"
			alias_def="${line#*=}"
			
			if [[ -n "${existing_aliases[$alias_name]}" ]]; then
				if [[ "${existing_aliases[$alias_name]}" == "$alias_def" ]]; then
					# Exact duplicate - skip
					skipped_duplicates+=("$alias_name")
				else
					# Conflict - report and fail
					log "Error: Alias conflict detected for '$alias_name'"
					echo "  Existing: alias $alias_name=${existing_aliases[$alias_name]}"
					echo "  New:      alias $alias_name=$alias_def"
					conflicts=1
				fi
			else
				# New alias - add it
				new_aliases+=("$line")
			fi
		elif [[ $line =~ '^for[[:space:]]' ]]; then
			# Start of for loop - only include if not already present
			if [[ $has_for_loop -eq 0 ]]; then
				in_for_loop=1
				new_aliases+=("$line")
			else
				in_for_loop=2  # Skip mode
			fi
		elif [[ $line =~ '^done[[:space:]]*$' ]]; then
			# End of for loop
			if [[ $in_for_loop -eq 1 ]]; then
				new_aliases+=("$line")
			fi
			in_for_loop=0
		elif [[ $in_for_loop -eq 1 ]]; then
			# Inside for loop - include all lines
			new_aliases+=("$line")
		fi
	done < "zsh/aliases.zsh"
	
	# Exit if conflicts were found
	if [[ $conflicts -eq 1 ]]; then
		log "Aborting injection to prevent conflicts"
		return 1
	fi
	
	# Report what we're doing
	if [[ ${#skipped_duplicates[@]} -gt 0 ]]; then
		skipped_list=""
		for alias in "${skipped_duplicates[@]}"; do
			if [[ -z "$skipped_list" ]]; then
				skipped_list="$alias"
			else
				skipped_list="$skipped_list, $alias"
			fi
		done
		log "Skipping ${#skipped_duplicates[@]} duplicate aliases: $skipped_list"
	fi
	
	# Count new aliases (excluding comments/empty lines)
	new_alias_count=0
	for line in "${new_aliases[@]}"; do
		if [[ $line =~ ^alias[[:space:]]*[^[:space:]]+=.* ]]; then
			new_alias_count=$((new_alias_count + 1))
		fi
	done
	
	if [[ $new_alias_count -eq 0 ]]; then
		log "No new aliases to inject - all aliases already present"
	else
		log "Injecting $new_alias_count new aliases..."
		
		# Create target file if it doesn't exist
		if [[ ! -f "$target_file" ]]; then
			touch "$target_file"
		fi
		
		# Add injection header
		echo "" >> "$target_file"
		echo "# ==== mac-dotfiles aliases injection $(date) ====" >> "$target_file"
		echo "" >> "$target_file"
		
		# Inject new content (aliases and functional code only)
		echo "# From zsh/aliases.zsh" >> "$target_file"
		for line in "${new_aliases[@]}"; do
			echo "$line" >> "$target_file"
		done
		echo "" >> "$target_file"
		echo "# ==== End mac-dotfiles injection ====" >> "$target_file"
		
		log "Aliases injected successfully to $target_file"
	fi
	
	return 0
}