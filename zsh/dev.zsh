
silent_unalias versions

function versions() {
	bun_version=$(bun --version)
	echo "Bun: $bun_version"

	node_version="$(node --version)"
	echo "Node: $node_version"

	npm_version="$(npm --version)"
	echo "Npm: $npm_version" 
	
	python_version="$(python --version)"
	echo "Python: $python_version"

	ruby_version="$(ruby --version)"
	echo "Ruby: $ruby_version"
}
