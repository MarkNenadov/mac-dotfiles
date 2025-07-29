# print memory usage information
# Usage: memstat
function memstat() {
    top -l 1 | grep PhysMem
}